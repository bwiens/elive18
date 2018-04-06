--------------------------------------------------------
--  File created - Friday-April-06-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure XMCGURFEED
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FIMSMGR"."XMCGURFEED" as

--
   cursor xmcgurf_cursor is
      select xmcgurf_trans_type,
             xmcgurf_batch,
             greatest(xmcgurf_trans_date, (to_date('7/1/2017', 'mm/dd/yyyy'))),
             xmcgurf_description,
             xmcgurf_amount,
             xmcgurf_dr_cr_ind,
             xmcgurf_ref,
             xmcgurf_index,
             xmcgurf_account,
             xmcgurf_misc,
             xmcgurf_bank,
             xmcgurf_batch_file,
             xmcgurf_entry_date,
             xmcgurf_process_date,
             xmcgurf_rule_detail_code,
             xmcgurf_id,
             xmcgurf_activity,
             xmcgurf_doc_code,
             xmcgurf_seq_num
        from xmcgurf
       where xmcgurf_process_date is null and
             xmcgurf_trans_type <> 'AR' and
             xmcgurf_trans_type <> 'CR' and
             xmcgurf_amount <> 0
       order by xmcgurf_batch,
                xmcgurf_batch_file,
                xmcgurf_trans_date,
                xmcgurf_description,
                xmcgurf_amount,
                xmcgurf_dr_cr_ind
         for update of xmcgurf_process_date,
                       xmcgurf_doc_code,
                       xmcgurf_seq_num;
--
   cursor xmcgurf_cursor2 is
      select xmcgurf_trans_type,
             xmcgurf_batch,
             greatest(xmcgurf_trans_date, (to_date('7/1/2017', 'mm/dd/yyyy'))) xmcgurf_trans_date,
             xmcgurf_description,
             xmcgurf_amount,
             xmcgurf_dr_cr_ind,
             xmcgurf_ref,
             xmcgurf_index,
             xmcgurf_account,
             xmcgurf_misc,
             xmcgurf_bank,
             xmcgurf_batch_file,
             xmcgurf_entry_date,
             xmcgurf_process_date,
             xmcgurf_rule_detail_code,
             xmcgurf_id,
             xmcgurf_activity,
             xmcgurf_doc_code,
             xmcgurf_seq_num
        from xmcgurf
       where xmcgurf_process_date is null and
            (xmcgurf_trans_type = 'AR' or
             xmcgurf_trans_type = 'CR') and
             xmcgurf_amount <> 0
       order by xmcgurf_batch,
                xmcgurf_batch_file,
                xmcgurf_trans_date,
                xmcgurf_description,
                xmcgurf_amount,
                xmcgurf_dr_cr_ind
         for update of xmcgurf_process_date,
                       xmcgurf_seq_num;
--
   cursor fobseqn_cursor is
      select fobseqn_maxseqno_7
        from fobseqn
       where fobseqn.fobseqn_seqno_type = 'F'
         for update of fobseqn_maxseqno_7;
--
   vmcgurf            xmcgurf_cursor2%rowtype;
   vacci              ftvacci%rowtype;
   vacci_count        number;
   vcurr_batch        xmcgurf.xmcgurf_batch%type;
   vcurr_batch_file   xmcgurf.xmcgurf_batch_file%type;
   vcurr_trans_date   xmcgurf.xmcgurf_trans_date%type;
   vdescription       taismgr.tbraccd.tbraccd_desc%type;
   vdetail_code       taismgr.tbraccd.tbraccd_detail_code%type;
   vdoc_num           fobseqn.fobseqn_maxseqno_7%type;
   vsystem_id         general.gurfeed.gurfeed_system_id%type;
   vsystem_time_stamp general.gurfeed.gurfeed_system_time_stamp%type;
   vdoc_code          general.gurfeed.gurfeed_doc_code%type;
   vseq_num           general.gurfeed.gurfeed_seq_num%type;
   vrec_lim           vseq_num%type;
   vuser_id           general.gurfeed.gurfeed_user_id%type;
   vrucl_code         general.gurfeed.gurfeed_rucl_code%type;
   vbatch_name        general.gurfeed.gurfeed_doc_ref_num%type;
   vbatch_file        general.gurfeed.gurfeed_trans_desc%type;
   vtrans_date        general.gurfeed.gurfeed_trans_date%type;
   vhash_total        general.gurfeed.gurfeed_trans_amt%type;
   vbudg_period       general.gurfeed.gurfeed_budget_period%type;
   vbank_code         general.gurfeed.gurfeed_bank_code%type;
   vactv_code         general.gurfeed.gurfeed_actv_code%type;
   vacct_code         general.gurfeed.gurfeed_acct_code%type;
   vperiod_loc        number;
   vpidm              saturn.spriden.spriden_pidm%type;
   vpidm_count        number;
   vsession_count     number;
   vtran_number       taismgr.tbraccd.tbraccd_tran_number%type;
   vterm              varchar2(10);
   vtoday             varchar2(8);
   vtoday_year        varchar2(4);
   vtoday_yearprev    varchar2(4);
   vtoday_monthday    varchar2(4);
--
   vtrans_type        tbbdetc.tbbdetc_type_ind%type;
   vtrans_balance     xmcgurf.xmcgurf_amount%type;
--
begin
--
-- Process ledger entries first
--
   open xmcgurf_cursor;
--
   vrec_lim := 9990;
   vcurr_batch := 'XdummyX';
   vcurr_batch_file := vcurr_batch;
   vseq_num := 0;
   vcurr_trans_date := sysdate;
   vsystem_id := 'XFEED';
   vsystem_time_stamp := to_char(sysdate,'YYYYMMDDHH24MISS');
   vuser_id := 'XFEED';
--
   loop
      fetch xmcgurf_cursor into vmcgurf;
      exit when xmcgurf_cursor%notfound;
--
-- When the batch or date changes, or when you hit vrec_lim records,
-- create a new document
--
-- Update the header record of the prior document with the correct
-- total
--
      if (((vmcgurf.xmcgurf_batch <> vcurr_batch or
            vmcgurf.xmcgurf_batch_file <> vcurr_batch_file or
            vmcgurf.xmcgurf_trans_date <> vcurr_trans_date) and
            vcurr_batch <> 'XdummyX') or
            vseq_num >= vrec_lim) then
          select sum(gurfeed_trans_amt) into vhash_total
             from gurfeed
             where gurfeed_doc_code = vdoc_code and
                   gurfeed_rec_type = '2';
          update gurfeed
             set gurfeed_trans_amt = vhash_total
             where gurfeed_doc_code = vdoc_code and
                   gurfeed_rec_type = '1';
      end if;
--
-- Build the new document code from FOBSEQN
--
      if (vmcgurf.xmcgurf_batch <> vcurr_batch or
          vmcgurf.xmcgurf_batch_file <> vcurr_batch_file or
          vmcgurf.xmcgurf_trans_date <> vcurr_trans_date or
          vseq_num >= vrec_lim) then
         open fobseqn_cursor;
         fetch fobseqn_cursor into vdoc_num;
         vdoc_num := vdoc_num + 1;
         update fobseqn
            set fobseqn_maxseqno_7 = vdoc_num
            where current of fobseqn_cursor;
         close fobseqn_cursor;
         vdoc_code := 'F'||ltrim(to_char(vdoc_num,'0999999'));
         vbatch_name := substr(vmcgurf.xmcgurf_batch,1,8);
         vbatch_file := vmcgurf.xmcgurf_batch_file;
         vseq_num := 0;
--
-- Create a header record for the new document
--
         insert into general.gurfeed
                (gurfeed_system_id,
                 gurfeed_system_time_stamp,
                 gurfeed_doc_code,
                 gurfeed_rec_type,
                 gurfeed_seq_num,
                 gurfeed_activity_date,
                 gurfeed_user_id,
                 gurfeed_doc_ref_num,
                 gurfeed_trans_date,
                 gurfeed_trans_amt,
                 gurfeed_trans_desc)
         values (vsystem_id,
                 vsystem_time_stamp,
                 vdoc_code,
                 '1',
                 0,
                 sysdate,
                 vuser_id,
                 vbatch_name,
                 vmcgurf.xmcgurf_trans_date,
                 0,
                 vbatch_file);
      end if;
--
-- Create detail records
--
      vcurr_batch := vmcgurf.xmcgurf_batch;
      vcurr_batch_file := vmcgurf.xmcgurf_batch_file;
      vcurr_trans_date := vmcgurf.xmcgurf_trans_date;
      vseq_num := vseq_num + 1;
      vbudg_period := null;
--
      if vmcgurf.xmcgurf_bank is null then
         vbank_code := 'CO';
      else
         vbank_code := vmcgurf.xmcgurf_bank;
      end if;
--
      if vmcgurf.xmcgurf_rule_detail_code is not null then
         vrucl_code := vmcgurf.xmcgurf_rule_detail_code;
      else
         case vmcgurf.xmcgurf_trans_type
            when 'BU' then vrucl_code := 'BD01';
            when 'BB' then vrucl_code := 'BBG';
            when 'JE' then vrucl_code := 'JE16';
            when 'AR' then vrucl_code := 'JE16';
            when 'CR' then vrucl_code := 'CR05';
            when 'PY' then vrucl_code := 'JE16';
            else vrucl_code := 'xxxx';
         end case;
      end if;
--
      vperiod_loc := instr(vmcgurf.xmcgurf_batch_file,'.');
      if (vperiod_loc = 0 or
          vperiod_loc >= 9) then
         vbatch_name := substr(vmcgurf.xmcgurf_batch,1,8);
      else
         vbatch_name := substr(vmcgurf.xmcgurf_batch,1,vperiod_loc - 1);
      end if;
--
--  Expand account index information into full FOAPAL
--
      select count(*) into vacci_count
         from ftvacci
         where ftvacci_coas_code = '1' and
               ftvacci_acci_code = vmcgurf.xmcgurf_index and
               ftvacci_nchg_date = to_date('12/31/2099','mm/dd/yyyy') and
               ftvacci_term_date is null and
               ftvacci_status_ind = 'A';
--
      if vacci_count = 1 then
         select * into vacci
            from ftvacci
            where ftvacci_coas_code = '1' and
                  ftvacci_acci_code = vmcgurf.xmcgurf_index and
                  ftvacci_nchg_date = to_date('12/31/2099','mm/dd/yyyy') and
                  ftvacci_term_date is null and
                  ftvacci_status_ind = 'A';
      else
         vacci.ftvacci_fund_code := null;
         vacci.ftvacci_orgn_code := null;
         vacci.ftvacci_acct_code := null;
         vacci.ftvacci_prog_code := null;
         vacci.ftvacci_actv_code := null;
         vacci.ftvacci_locn_code := null;
      end if;
--
      if vacci.ftvacci_acct_code is not null then
         vacct_code := vacci.ftvacci_acct_code;
      else
         vacct_code := vmcgurf.xmcgurf_account;
      end if;
--
      if vmcgurf.xmcgurf_activity is not null then
         vactv_code := vmcgurf.xmcgurf_activity;
      else
         vactv_code := vacci.ftvacci_actv_code;
      end if;
--
      insert into general.gurfeed
             (gurfeed_system_id,
              gurfeed_system_time_stamp,
              gurfeed_doc_code,
              gurfeed_rec_type,
              gurfeed_seq_num,
              gurfeed_activity_date,
              gurfeed_user_id,
              gurfeed_rucl_code,
              gurfeed_doc_ref_num,
              gurfeed_trans_date,
              gurfeed_trans_amt,
              gurfeed_trans_desc,
              gurfeed_dr_cr_ind,
              gurfeed_coas_code,
              gurfeed_acci_code,
              gurfeed_fund_code,
              gurfeed_orgn_code,
              gurfeed_acct_code,
              gurfeed_prog_code,
              gurfeed_actv_code,
              gurfeed_locn_code,
              gurfeed_budget_period,
              gurfeed_bank_code)
      values (vsystem_id,
              vsystem_time_stamp,
              vdoc_code,
              '2',
              vseq_num,
              sysdate,
              vuser_id,
              vrucl_code,
              vbatch_name,
              vmcgurf.xmcgurf_trans_date,
              vmcgurf.xmcgurf_amount,
              vmcgurf.xmcgurf_description,
              vmcgurf.xmcgurf_dr_cr_ind,
              '1',
              vmcgurf.xmcgurf_index,
              vacci.ftvacci_fund_code,
              vacci.ftvacci_orgn_code,
              vacct_code,
              vacci.ftvacci_prog_code,
              vactv_code,
              vacci.ftvacci_locn_code,
              vbudg_period,
              vbank_code);
--
-- Mark the intermediate records as processed
--
      update xmcgurf
         set xmcgurf_process_date = sysdate,
             xmcgurf_doc_code = vdoc_code,
             xmcgurf_seq_num = vseq_num
         where current of xmcgurf_cursor;
--
   end loop;
--
-- Update the header record of the prior document with the correct
-- total
--
      if vcurr_batch <> 'XdummyX' then
         select sum(gurfeed_trans_amt) into vhash_total
            from gurfeed
            where gurfeed_doc_code = vdoc_code and
                  gurfeed_rec_type = '2';
         update gurfeed
            set gurfeed_trans_amt = vhash_total
            where gurfeed_doc_code = vdoc_code and
                  gurfeed_rec_type = '1';
      end if;
--
   if xmcgurf_cursor%isopen then
      close xmcgurf_cursor;
   end if;
--
   commit;
--
--
-- Process accounts receivable entries next
--
--
-- Figure out which term to be looking for
--
--   vtoday := to_char(sysdate,'yyyymmdd');
--   vtoday_year := substr(vtoday,1,4);
--   vtoday_yearprev := to_char(to_number(vtoday_year) - 1);
--   vtoday_monthday := substr(vtoday,5,4);
--   if vtoday_monthday >= '0815' and
--      vtoday_monthday <= '1231' then
--      vterm := vtoday_year||'10';
--   elsif vtoday_monthday >= '0601' and
--         vtoday_monthday <= '0814' then
--      vterm := vtoday_yearprev||'30';
--   else
--      vterm := vtoday_yearprev||'20';
--   end if;
--
   vterm:= messiah.mc_ar_util.get_ar_term(sysdate);
--
   open xmcgurf_cursor2;
--
   vcurr_trans_date := sysdate;
   vuser_id := 'CONVERT';
--
   loop
      fetch xmcgurf_cursor2 into vmcgurf;
      exit when xmcgurf_cursor2%notfound;
--
-- Create detail records
--
      vpidm := null;
      vpidm_count := 0;
      vtran_number := 0;
      vdescription := substr(vmcgurf.xmcgurf_description,1,30);
--
      select count(*) into vpidm_count
         from spriden
         where spriden_id = vmcgurf.xmcgurf_id and
               spriden_change_ind is null;
--
      if vpidm_count > 0 then
--
         select spriden_pidm into vpidm
            from spriden
            where spriden_id = vmcgurf.xmcgurf_id and
                  spriden_change_ind is null;
--
         select nvl(max(tbraccd_tran_number),0) + 1 into vtran_number
            from tbraccd
            where tbraccd_pidm = vpidm;
--
         if vmcgurf.xmcgurf_rule_detail_code is not null then
            vdetail_code := vmcgurf.xmcgurf_rule_detail_code;
         else
            vdetail_code := 'FMSR';
         end if;
--
         vtrans_type:= messiah.mc_fin_util.get_tbbdetc_type(vdetail_code);
         IF vtrans_type = 'P' then
            vtrans_balance:= 0 - vmcgurf.xmcgurf_amount;
         ELSE
            vtrans_balance:= vmcgurf.xmcgurf_amount;
         END IF;
--
         insert into tbraccd
            (tbraccd_pidm,
             tbraccd_tran_number,
             tbraccd_term_code,
             tbraccd_detail_code,
             tbraccd_user,
             tbraccd_entry_date,
             tbraccd_amount,
             tbraccd_balance,
             tbraccd_effective_date,
             tbraccd_desc,
             tbraccd_srce_code,
             tbraccd_acct_feed_ind,
             tbraccd_activity_date,
             tbraccd_session_number,
             tbraccd_document_number,
             tbraccd_trans_date,
             tbraccd_payment_id)
         values
            (vpidm,
             vtran_number,
             vterm,
             vdetail_code,
             vuser_id,
             vcurr_trans_date,
             vmcgurf.xmcgurf_amount,
             vtrans_balance,
             vmcgurf.xmcgurf_trans_date,
             vdescription,
             'T',
             'Y',
             vcurr_trans_date,
             0,
             vmcgurf.xmcgurf_ref,
             vmcgurf.xmcgurf_trans_date,
             vmcgurf.xmcgurf_batch);
--
-- Mark the intermediate records as processed
--
         update xmcgurf
            set xmcgurf_process_date = sysdate,
                xmcgurf_seq_num = vtran_number
            where current of xmcgurf_cursor2;
--
      end if;
--
   end loop;
--
   if xmcgurf_cursor2%isopen then
      close xmcgurf_cursor2;
   end if;
--
   commit;
--
end;

/
