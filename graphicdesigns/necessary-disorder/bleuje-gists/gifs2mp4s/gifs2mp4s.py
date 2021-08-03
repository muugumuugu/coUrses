import os
import glob
from PIL import Image
import math

'''
Parameters
'''
result_folder = "res"

min_frames = 250

'''
End of parameters
'''

if not os.path.exists(result_folder):
    os.makedirs(result_folder)

l = []

for stri in glob.glob("*.gif"):
    print(stri);
    l.append(stri)

k = 1;

for f in l:
    print("-----",k,"/",len(l),"-----")
    k += 1
    d = os.path.splitext(f)[0]

    im = Image.open(f)
    print("nb frames:",im.n_frames)
    
    nbloop = max(1,math.floor((1.0*min_frames)/im.n_frames))
    
    cmd1 = "ffmpeg -stream_loop "+str(nbloop)+" -i "+f+" "+result_folder+"/loop.gif -y"
    cmd2 = "ffmpeg -i "+result_folder+"/loop.gif -pix_fmt yuv420p -vf \"scale=trunc(iw/2)*2:trunc(ih/2)*2\" "+result_folder+"/"+d+".mp4 -y"
    print("cmd1:",cmd1)
    print("cmd2:",cmd2)
    os.system(cmd1)
    os.system(cmd2)