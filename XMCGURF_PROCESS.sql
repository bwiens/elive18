--------------------------------------------------------
--  File created - Friday-April-06-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure XMCGURF_PROCESS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FIMSMGR"."XMCGURF_PROCESS" as
--
   cursor xmcgurf_cursor is
      select xmcgurf_trans_type,
             xmcgurf_batch,
             xmcgurf_trans_date,
             xmcgurf_description,
             xmcgurf_amount,
             case xmcgurf_trans_type
                when 'AR'
                then
                   trim(xmcgurf_trans_type)||chr(38)||'nbsp'||
                   trim(xmcgurf_id)||chr(38)||'nbsp'||
                   trim(xmcgurf_rule_detail_code)
                else
                   trim(xmcgurf_trans_type)||chr(38)||'nbsp'||
                   trim(xmcgurf_dr_cr_ind)||chr(38)||'nbsp'||
                   trim(xmcgurf_index)||chr(38)||'nbsp'||
                   trim(xmcgurf_account)||chr(38)||'nbsp'||
                   trim(xmcgurf_activity)
             end xmcgurf_accounting
        from xmcgurf
       where (select global_name
                from global_name) = 'BANR.MESSIAH.EDU'
       order by xmcgurf_batch, xmcgurf_trans_type, xmcgurf_trans_date, xmcgurf_description,
                xmcgurf_amount, xmcgurf_accounting;
--
   xmcgurf_rec        xmcgurf_cursor%rowtype;
   rec_count          number;
   day_of_week        number;
--
   sender             varchar2(100);
   to_list            OWA_UTIL.ident_arr;
   cc_list            OWA_UTIL.ident_arr;
   bcc_list           OWA_UTIL.ident_arr;
   msg_subj           varchar2(100);
   connection         UTL_SMTP.connection;
   line_count         number;
--
  v_db                varchar(40); 
--
begin
-- make sure we are not in test
select global_name into v_db from global_name;
  if v_db = 'TEST.MESSIAH.EDU' then
  return;
end if;
--
-- this emails the contents of xmcgurf, processes the records,
-- archives them, and emails any records that would not process
--
   day_of_week := to_number(to_char(sysdate, 'D'));
--
   if day_of_week > 1 and day_of_week < 7 then
--
      sender := '--';
      to_list(1) := '--';
      to_list(2) := '--';
      bcc_list(1) := '--';
--
      msg_subj := 'XMCGURF Transactions';
      mc_email.p_start_mail(Sender => sender,
                            TOList => to_list,
                            Subject => msg_subj,
                            CCList => cc_list,
                            BCCList => bcc_list,
                            ContentType => 'text/html',
                            MailConnect => connection);
      mc_email.p_addto_mail(connection,'<html>');
      mc_email.p_addto_mail(connection,'<head></head>');
      mc_email.p_addto_mail(connection,'<body bgcolor="#DDDDDD" text="#000066" link="#0000FF" '||
                                       'vlink="#CC0000" alink="#FF9933">');
      mc_email.p_addto_mail(connection,'<b>'||msg_subj||'</b><p>');
      mc_email.p_addto_mail(connection,'<table border=0 width=640 cellspace=0 cellpadding=1>');
      mc_email.p_addto_mail(connection,'<tr><td width=10%><b><font size=-1>Batch</b>'||
                                       '</td><td width=10%><b><font size=-1>Date</b>'||
                                       '</td><td width=44%><b><font size=-1>Description</b>'||
                                       '</td><td width=24%><b><font size=-1>Accounting</b>'||
                                       '</td><td width=12% align="right"><b><font size=-1>Amount</b>'||
                                       '</td></tr>');
      mc_email.p_addto_mail(connection,'<tr><td>'||chr(38)||'nbsp'||
                                       '</td><td>'||chr(38)||'nbsp'||
                                       '</td><td>'||chr(38)||'nbsp'||
                                       '</td><td>'||chr(38)||'nbsp'||
                                       '</td><td>'||chr(38)||'nbsp'||
                                       '</td></tr>');
--
      rec_count := 0;
      select count(*) into rec_count
        from xmcgurf;
--
      if rec_count > 0 then
--
         open xmcgurf_cursor;
--
         loop
            fetch xmcgurf_cursor into xmcgurf_rec;
            exit when xmcgurf_cursor%notfound;
--
            mc_email.p_addto_mail(connection,'<tr><td><font size=-1>'||xmcgurf_rec.xmcgurf_batch||
                                             '</td><td><font size=-1>'||to_char(xmcgurf_rec.xmcgurf_trans_date,'mm/dd/yyyy')||
                                             '</td><td><font size=-1>'||xmcgurf_rec.xmcgurf_description||
                                             '</td><td><font size=-1>'||xmcgurf_rec.xmcgurf_accounting||
                                             '</td><td align="right"><font size=-1>'||to_char(xmcgurf_rec.xmcgurf_amount,'999,999.00')||
                                             '</td></tr>');
--
         end loop;
--
         if xmcgurf_cursor%isopen then
            close xmcgurf_cursor;
         end if;
--
      else
--
         mc_email.p_addto_mail(connection,'<tr><td colspan=5><font size=-1>'||
                                          'There were no XMCGURF transactions.'||
                                          '</td></tr>');
--
      end if;
--
      mc_email.p_addto_mail(connection,'</table>');
      mc_email.p_addto_mail(connection,'</body></html>');
--
      mc_email.p_finish_mail(connection);
--
      if xmcgurf_cursor%isopen then
         close xmcgurf_cursor;
      end if;
--
      xmcgurfeed;
--
      dbms_lock.sleep(10);
--
      xmcgurf_archive;
--
      msg_subj := 'XMCGURF Problems';
      mc_email.p_start_mail(Sender => sender,
                            TOList => to_list,
                            Subject => msg_subj,
                            CCList => cc_list,
                            BCCList => bcc_list,
                            ContentType => 'text/html',
                            MailConnect => connection);
      mc_email.p_addto_mail(connection,'<html>');
      mc_email.p_addto_mail(connection,'<head></head>');
      mc_email.p_addto_mail(connection,'<body bgcolor="#DDDDDD" text="#000066" link="#0000FF" '||
                                       'vlink="#CC0000" alink="#FF9933">');
      mc_email.p_addto_mail(connection,'<b>'||msg_subj||'</b><p>');
      mc_email.p_addto_mail(connection,'<table border=0 width=640 cellspace=0 cellpadding=1>');
      mc_email.p_addto_mail(connection,'<tr><td width=10%><b><font size=-1>Batch</b>'||
                                       '</td><td width=10%><b><font size=-1>Date</b>'||
                                       '</td><td width=44%><b><font size=-1>Description</b>'||
                                       '</td><td width=24%><b><font size=-1>Accounting</b>'||
                                       '</td><td width=12% align="right"><b><font size=-1>Amount</b>'||
                                       '</td></tr>');
      mc_email.p_addto_mail(connection,'<tr><td>'||chr(38)||'nbsp'||
                                       '</td><td>'||chr(38)||'nbsp'||
                                       '</td><td>'||chr(38)||'nbsp'||
                                       '</td><td>'||chr(38)||'nbsp'||
                                       '</td><td>'||chr(38)||'nbsp'||
                                       '</td></tr>');
--
      rec_count := 0;
      select count(*) into rec_count
        from xmcgurf;
--
      if rec_count > 0 then
--
         open xmcgurf_cursor;
--
         loop
            fetch xmcgurf_cursor into xmcgurf_rec;
            exit when xmcgurf_cursor%notfound;
--
            mc_email.p_addto_mail(connection,'<tr><td><font size=-1>'||xmcgurf_rec.xmcgurf_batch||
                                             '</td><td><font size=-1>'||to_char(xmcgurf_rec.xmcgurf_trans_date,'mm/dd/yyyy')||
                                             '</td><td><font size=-1>'||xmcgurf_rec.xmcgurf_description||
                                             '</td><td><font size=-1>'||xmcgurf_rec.xmcgurf_accounting||
                                             '</td><td align="right"><font size=-1>'||to_char(xmcgurf_rec.xmcgurf_amount,'999,999.00')||
                                             '</td></tr>');
--
         end loop;
--
         if xmcgurf_cursor%isopen then
            close xmcgurf_cursor;
         end if;
--
      else
--
         mc_email.p_addto_mail(connection,'<tr><td colspan=5><font size=-1>'||
                                          'There were no XMCGURF problems.'||
                                          '</td></tr>');
--
      end if;
--
      mc_email.p_addto_mail(connection,'</table>');
      mc_email.p_addto_mail(connection,'</body></html>');
--
      mc_email.p_finish_mail(connection);
--
      if xmcgurf_cursor%isopen then
         close xmcgurf_cursor;
      end if;
--
   end if;
--
   commit;
--
end;

/
