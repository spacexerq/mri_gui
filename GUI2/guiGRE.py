# -*- coding: utf-8 -*-
"""
Created on Mon Jul  3 17:53:21 2023

@author: zilya
"""

import pickle
import tkinter as tk
from math import ceil 
import numpy as np
from types import SimpleNamespace


def set_limits():
    gamma = 42.576e6
    G_amp_max = 28                     # mT/m. Maximum of gradient
    G_amp_max = G_amp_max*1e-3*gamma  # Hz/m. Maximum of gradient
    G_slew_max = 130                   # T/m/s. Maximum slew rate
    G_slew_max = G_slew_max*gamma      # Hz/m/s. Maximum slew rate
    G_raster = 10e-6                   # s. Raster time for gradient waveforms
    rf_raster = 1e-6                   # s. Raster time for radio-frequency pulses
    t_ex = 0.512e-3                   # s. Duration of the exciting rf pulse
    t_BW_product_ex = 2.13
    t_ref = 3e-3
    rf_raster_time = 4e-6
    grad_raster_time = 8e-6
    tau_max = G_amp_max/G_slew_max
    tau_max = np.ceil(tau_max/ grad_raster_time)*grad_raster_time
    BW_ex_pulse = t_BW_product_ex/t_ex          # Hz. BW of ext pulse 

    sl_nb = float(textBox1.get())
    sl_thkn = float(textBox2.get())
    sl_gap = float(textBox3.get())
    FoV_f = float(textBox4.get())
    FoV_ph = float(textBox5.get())
    Nf = float(textBox6.get())
    Np = float(textBox7.get())
    BW_pixel = float(textBox8.get())
    TE = float(textBox9.get())
    TR = float(textBox10.get())
    alpha = float(textBox11.get())
    
    sl_thkn_min = BW_ex_pulse/G_amp_max
    sl_thkn_max = 20e-3
    
    TE = np.ceil(TE/ grad_raster_time)*grad_raster_time
    TR = np.ceil(TR/ grad_raster_time)*grad_raster_time

    t_read = 1/BW_pixel
    t_reph = 1e-3
    tau_ex = BW_ex_pulse/(sl_thkn*G_slew_max)
    t_sps = 4/(sl_thkn*G_amp_max) - tau_max
    t_spf = 2*Nf/(FoV_f*G_amp_max) - tau_max
    
    t_read = np.ceil(t_read/ grad_raster_time)*grad_raster_time
    t_reph = np.ceil(t_reph/ grad_raster_time)*grad_raster_time
    tau_ex = np.ceil(tau_ex/ grad_raster_time)*grad_raster_time
    t_sps = np.ceil(t_sps/ grad_raster_time)*grad_raster_time
    t_spf = np.ceil(t_spf/ grad_raster_time)*grad_raster_time
    
    
    TE_min = t_ex/2 + tau_ex + t_reph + tau_max + t_read/2
    TE_max = TR - (t_ex/2 + tau_ex + t_read/2 + tau_max + max((t_sps+2*tau_max),(t_sps+2*tau_max),t_reph))
    TR_min = TE + t_ex/2 + tau_ex + t_read/2 + tau_max + max((t_sps+2*tau_max),(t_sps+2*tau_max),t_reph)
    TR_max = 10
    
    TE_min = np.ceil(TE_min/ grad_raster_time)*grad_raster_time
    TE_max = np.ceil(TE_max/ grad_raster_time)*grad_raster_time
    TR_min = np.ceil(TR_min/ grad_raster_time)*grad_raster_time
    
    
    Nf_min = 1
    Nf_max = 2*FoV_f*G_amp_max*(t_reph-tau_max)
    Np_min = 1
    Np_max = Nf
    
    
    FoV_min = 25e-3
    FoV_f_min = Nf/(2*G_amp_max*(t_reph-tau_max))
    FoV_f_min = max(FoV_f_min,FoV_min) 
    FoV_f_max = 450e-3
    FoV_ph_min = Np/(2*G_amp_max*(t_reph-tau_max))
    FoV_ph_min = max(FoV_ph_min,FoV_min) 
    FoV_ph_max = FoV_f
    
    BW_pixel_min = 1/(2*(TE-t_ex/2-tau_ex-t_reph-tau_max))
    BW_pixel_max = 1780
    
    angle_min, angle_max = 1, 90
    
    label2_1.configure(text = "min = " + str(ceil(sl_thkn_min*1000)/1000))
    label2_2.configure(text = "max = " + str(sl_thkn_max))
    label4_1.configure(text = "min = " + str(ceil(FoV_f_min*1000)/1000))
    label4_2.configure(text = "max = " + str(FoV_f_max))
    label5_1.configure(text = "min = " + str(ceil(FoV_ph_min*1000)/1000))
    label5_2.configure(text = "max = " + str(FoV_ph_max))
    label6_1.configure(text = "min = " + str(Nf_min))
    label6_2.configure(text = "max = " + str(ceil(Nf_max)))
    label7_1.configure(text = "min = " + str(Np_min))
    label7_2.configure(text = "max = " + str(Np_max))
    label8_1.configure(text = "min = " + str(max(ceil(BW_pixel_min), 40)))
    label8_2.configure(text = "max = " + str(BW_pixel_max))
    label9_1.configure(text = "min = " + str(ceil(TE_min*1000000)/1000000))
    label9_2.configure(text = "max = " + str(ceil(TE_max*1000000)/1000000))
    label10_1.configure(text = "min = " + str(ceil(TR_min*1000000)/1000000))
    label10_2.configure(text = "max = " + str(TR_max))
    label11_1.configure(text = "min = " + str(angle_min))
    label11_2.configure(text = "max = " + str(angle_max))
    
    
    global param
    param = SimpleNamespace()
    param.t_BW_product_ex = t_BW_product_ex
    param.t_ex = t_ex
    param.t_ex = t_ex
    param.t_ref = t_ref
    param.sl_nb = sl_nb
    param.sl_thkn = sl_thkn   
    param.sl_gap = sl_gap
    param.FoV_f = FoV_f
    param.FoV_ph = FoV_ph
    param.Nf = Nf
    param.Np = Np   
    param.BW_pixel = BW_pixel
    param.TE = TE
    
    #time = TR*sl_nb*Np
   # tk.Label(win, text = 'tread = ' + str(t_read) ).grid(row=12, column=2,sticky = "E")
   # tk.Label(win, text = 'TEmin = ' + str(TE_min) ).grid(row=13, column=2,sticky = "E")
    tk.Label(win, text = 'tau min = ' + str(tau_max) ).grid(row=14, column=2,sticky = "E")
   # tk.Label(win, text = 'tauex = ' + str(tau_ex) ).grid(row=15, column=2,sticky = "E")

def save_param():
    file = open('GRE_pulsequence_parameters.txt', 'wb')
    pickle.dump(param, file)
    file.close()    

### Defoult values ###
# --------------------------------
sl_nb = 5          # number of slices                     
sl_thkn = 7e-3     # Slice thickness, m                   
sl_gap = 100       # Slice gap, %   
                      
#---------------------------------
FoV_f = 200e-3    # FoV in freq encoding direction, m                  
FoV_ph = 200e-3   # FoV in ph encoding direction, m               
Nf = 128          # Freq direction resolution                         
Np = 128          # Resolution in ph encoding direction              

#----------------------------------
BW_pixel = 500    # Pixel BW 
TE = 6e-3         # Echo time, s
TR =  20e-3       # Repetition time, s
alpha = 90        # Flip angle, degree 
           

win = tk.Tk()
win.title('GRE')
win.geometry("390x350+100+100")
win.resizable(False,False)


# number of slices
sl_nb_min,sl_nb_max = 1, 103
tk.Label(win, text = 'Slices').grid(row=0, column=0,sticky = "E")
textBox1 = tk.Spinbox(from_=sl_nb_min, to=sl_nb_max, width = 4)
#textBox1.insert(0, sl_nb)
textBox1.grid(row=0, column=1)
label1_1 = tk.Label(win, text = "min = " + str(sl_nb_min))
label1_1.grid(row=0, column=2)
label1_2 = tk.Label(win, text = "max = " + str(sl_nb_max))
label1_2.grid(row=0, column=3)

# Slice thickness, m  
tk.Label(win, text = 'Slice thickness, m').grid(row=1, column=0,sticky = "E")
textBox2 = tk.Entry(width = 6)
textBox2.insert(0, sl_thkn)
textBox2.grid(row=1, column=1)
label2_1 = tk.Label(win, text = "min = " )
label2_1.grid(row=1, column=2)
label2_2 = tk.Label(win, text = "max = " )
label2_2.grid(row=1, column=3)

# Slice gap, %  
tk.Label(win, text = 'Slice gap, % ').grid(row=2, column=0,sticky = "E")
textBox3 = tk.Entry(width = 6)
textBox3.insert(0, sl_gap)
sl_gap_min, sl_gap_max = 0, 800
textBox3.grid(row=2, column=1)
label3_1 = tk.Label(win, text = "min = " + str(sl_gap_min))
label3_1.grid(row=2, column=2)
label3_2 = tk.Label(win, text = "max = " + str(sl_gap_max))
label3_2.grid(row=2, column=3)

# FoV in freq encoding direction, m
tk.Label(win, text = 'FoV read, m').grid(row=3, column=0,sticky = "E")
textBox4 = tk.Entry(width = 6)
textBox4.insert(0, FoV_f)
textBox4.grid(row=3, column=1)
label4_1 = tk.Label(win, text = "min = ")
label4_1.grid(row=3, column=2)
label4_2 = tk.Label(win, text = "max = ")
label4_2.grid(row=3, column=3)


# FoV in ph encoding direction, m  
label5 = tk.Label(win, text = 'FoV phase, m')
label5.grid(row=4, column=0,sticky = "E")
textBox5 = tk.Entry(width = 6)
textBox5.insert(0, FoV_f)
textBox5.grid(row=4, column=1)
label5_1 = tk.Label(win, text = "min = ")
label5_1.grid(row=4, column=2)
label5_2 = tk.Label(win, text = "max = ")
label5_2.grid(row=4, column=3)

# Freq direction resolution
label6 = tk.Label(win, text = 'Read resolution')
label6.grid(row=5, column=0,sticky = "E")
textBox6 = tk.Entry(width = 6)
textBox6.insert(0, Nf)
textBox6.grid(row=5, column=1)
label6_1 = tk.Label(win, text = "min = ")
label6_1.grid(row=5, column=2)
label6_2 = tk.Label(win, text = "max = ")
label6_2.grid(row=5, column=3)

# Ph direction resolution
label7 = tk.Label(win, text = 'Phase resolution')
label7.grid(row=6, column=0,sticky = "E")
textBox7 = tk.Entry(width = 6)
textBox7.insert(0, Np)
textBox7.grid(row=6, column=1)
label7_1 = tk.Label(win, text = "min = ")
label7_1.grid(row=6, column=2)
label7_2 = tk.Label(win, text = "max = ")
label7_2.grid(row=6, column=3)

# Pixel BW
label8 = tk.Label(win, text = 'Pixel BW')
label8.grid(row=7, column=0,sticky = "E")
textBox8 = tk.Entry(width = 6)
textBox8.insert(0, BW_pixel)
textBox8.grid(row=7, column=1)
label8_1 = tk.Label(win, text = "min = ")
label8_1.grid(row=7, column=2)
label8_2 = tk.Label(win, text = "max = ")
label8_2.grid(row=7, column=3)

# TE, s
label9 = tk.Label(win, text = 'TE')
label9.grid(row=8, column=0,sticky = "E")
textBox9 = tk.Entry(width = 6)
textBox9.insert(0, TE)
textBox9.grid(row=8, column=1)
label9_1 = tk.Label(win, text = "min = ")
label9_1.grid(row=8, column=2)
label9_2 = tk.Label(win, text = "max = ")
label9_2.grid(row=8, column=3)

# TR, s
label10 = tk.Label(win, text = 'TR')
label10.grid(row=9, column=0,sticky = "E")
textBox10 = tk.Entry(width = 6)
textBox10.insert(0, TR)
textBox10.grid(row=9, column=1)
label10_1 = tk.Label(win, text = "min = ")
label10_1.grid(row=9, column=2)
label10_2 = tk.Label(win, text = "max = ")
label10_2.grid(row=9, column=3)

# Flip angle, degree
label11= tk.Label(win, text = 'Flip angle, degree')
label11.grid(row=10, column=0,sticky = "E")
textBox11 = tk.Entry(width = 6)
textBox11.insert(0, alpha)
textBox11.grid(row=10, column=1)
label11_1 = tk.Label(win, text = "min = ")
label11_1.grid(row=10, column=2)
label11_2 = tk.Label(win, text = "max = ")
label11_2.grid(row=10, column=3)

set_limits()

btn1 = tk.Button(win, text = 'Set', command = set_limits)
btn1.grid(row=11, column=0)


btn1 = tk.Button(win, text = 'Save', command = save_param)
btn1.grid(row=11, column=3)


win.mainloop()


