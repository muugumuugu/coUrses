#!/usr/bin/python

from tkinter import *
from tkinter import ttk
import convert

def command_paste(*args):
	print(unicode_code.get())
	root.destroy()

def command_exit(*args):
	root.destroy()

def command_latex_code_changed(*args):
	try:
		unicode_code.set(convert.convert(latex_code.get()))
	except:
		msg = "Exception: "
		msg += str(sys.exc_info()[0])
		msg += ": "
		msg += str(sys.exc_info()[1])
		unicode_code.set(msg)

def center(window):
	sw = window.winfo_screenwidth()
	sh = window.winfo_screenheight()
	rw = window.winfo_reqwidth()
	rh = window.winfo_reqheight()
	xc = (sw - rw) / 2
	yc = (sh -rh) / 2
	window.geometry("+%d+%d" % (xc, yc))
	window.deiconify()

root = Tk()
root.withdraw()
root.resizable(0, 0)
root.title("Latex to Unicode converter")

mainframe = ttk.Frame(root, padding="3 3 12 12")
mainframe.grid(column=0, row=0, sticky=(N, W, E, S))
mainframe.columnconfigure(0, weight=1)
mainframe.rowconfigure(0, weight=1)

latex_code = StringVar()
latex_code.trace("w", command_latex_code_changed)
unicode_code = StringVar()

ttk.Label(mainframe, text="Latex:").grid(column=1, row=1, sticky=W)
ttk.Label(mainframe, text="Preview:").grid(column=1, row=2, sticky=W)

paste_button = ttk.Button(mainframe, text="Paste", command=command_paste)
paste_button.grid(column=3, row=3, sticky=W)

cancel_button = ttk.Button(mainframe, text="Cancel", command=command_exit)
cancel_button.grid(column=4, row=3, sticky=W)

latex_entry = ttk.Entry(mainframe, width=50, textvariable=latex_code)
latex_entry.grid(column=2, row=1, columnspan=3, sticky=(W,E))
latex_entry.focus_set()
latex_entry.bind("<KeyPress-Return>", command_paste)
latex_entry.bind("<KeyPress-Escape>", command_exit)

unicode_entry = ttk.Entry(mainframe, textvariable=unicode_code,state="readonly")
unicode_entry.grid(column=2, row=2, columnspan=3, sticky=(W,E))

for child in mainframe.winfo_children():
	child.grid_configure(padx=5, pady=5)

root.after(1, center, root)
root.mainloop()
