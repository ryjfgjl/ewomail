import PySimpleGUI as sg


layout = [
    [sg.Text('test')],
        ]
window = sg.Window('Ewomail Tool 1.0', layout)

while True:
    
    event, value = window.read()
    window.close()
    if event == None:
        break


