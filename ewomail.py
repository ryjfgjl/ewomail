# 批量新增账号

import PySimpleGUI as sg
import string
import random
from sql import Sql
from datetime import datetime, date
import pandas as pd
import traceback, sys, os
							

Sql = Sql()

def exception_format():
    """
    Convert exception info into a string suitable for display.
    """
    return "".join(traceback.format_exception(
        sys.exc_info()[0], sys.exc_info()[1], sys.exc_info()[2]
    ))


layout = [
	[sg.Text('服务器IP:     '),sg.Input(size=(20, 1), key='host', default_text='localhost')],
	[sg.Text('端口:           '),sg.Input(size=(6, 1), key='port', default_text='3306')],
	[sg.Text('数据库名称: '), sg.Input(size=(40, 1), key='db', default_text='ewomail')],
	[sg.Text('用户名:        '), sg.Input(size=(20, 1), key='user', default_text='root')],
	[sg.Text('密码:           '), sg.Input(size=(20, 1), key='passwd', default_text='root')],
	
	[sg.Text('自定义账号开头:'),sg.Input(size=(10, 1), key='account_start')],
	[sg.Text('自定义账号结尾:'),sg.Input(size=(10, 1), key='account_end')],
	[sg.Text('域名: @ukatoo.com')],

	[sg.Text('随机生成位数:'),sg.Input(size=(5, 1), key='digit')],
	[sg.Checkbox('随机生成数字', key='num',default=True),sg.Checkbox('随机生成小写字母', key='low',default=True),sg.Checkbox('随机生成大写字母', key='up',default=True)],

	[sg.Text('新增账号个数:'),sg.Input(size=(10, 1), key='cnt')],

	[sg.FolderBrowse('选择xls输出路径:',size=(20, 1), key='path'), sg.Text(size=(40, 1))],

	[sg.Text(' '*35),sg.Button('点击生成',size=(20, 2))],

]
expire_date = '2020-10-20'
left_day = (datetime.today() - datetime.strptime(expire_date,'%Y-%m-%d')).days
if left_day > 0:
	sg.PopupError('工具已过期, 请联系qq2577154121')
	layout = [[sg.Text('工具已过期, 请联系qq2577154121 ')]]

window = sg.Window(title='账号生成器 V1.0 试用版 过期日期: {}'.format(expire_date), layout=layout)

for i in range(1000000):
	event, values = window.read()
	if event is None:
		break

	try:
		if event == '点击生成':
			host = values['host']
			port = int(values['port'])
			db = values['db']
			user = values['user']
			passwd = values['passwd']

			db_conn = Sql.conn_db(host,port,user,passwd,db)

			account_start = values['account_start']
			account_end = values['account_end']
			digit = int(values['digit'])
			num = values['num']
			low = values['low']
			up = values['up']
			cnt = int(values['cnt'])
			path = values['path']


			# check input
			if digit < 0:
				sg.PopupError('随机生成位数不能为负')
				continue
			if not num and not low and not up:
				sg.PopupError('必须选择随机生成字符(数字,小写字母,大写字母)中的至少一个')
				continue
			if cnt < 0:
				sg.PopupError('生成个数不能为负')
				continue
			if not path:
				sg.PopupError('请选择xls输出路径')
				continue
			
			
			generate_cnt = 0
			accounts = []
			ctime = datetime.now()
			while generate_cnt < cnt:
				token = ''
				if num:
					token = token + string.digits
				if low:
					token = token + string.ascii_lowercase
				if up:
					token = token + string.ascii_uppercase

				token = random.sample(token,digit)
				token = ''.join(token)
				account = account_start + token + account_end + '@ukatoo.com'
				sql = 'select 1 from i_users where email = "{}"'.format(account)
				exist = Sql.exec_sql(db_conn,sql).fetchall()
				if exist:
					continue

				passwd = string.ascii_letters + string.digits
				passwd = random.sample(passwd,random.randint(8,16))
				passwd = ''.join(passwd)
				sql = 'insert into i_users(domain_id, email, password, maildir, ctime) values("{}","{}","{}","{}","{}")'.format(1,account,passwd,'/ewomail/mail/vmail/ukatoo.com/a/d/m/admin.20201013',ctime)
				Sql.exec_sql(db_conn,sql)

				accounts.append([account,passwd,ctime])
				generate_cnt+=1
				print('Email: {}, Password: {}'.format(account, passwd))

			df = pd.DataFrame(accounts, columns=['账号','密码','创建时间'])
			df.to_excel(path+r'\新增数据.xls')
			sg.Popup('','添加完成!')
	except:
		sg.PopupError(exception_format())
		continue

window.close()

		

