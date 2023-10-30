unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Types, Unit2, process, math,LCLType, IniFiles;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
    ListBox4: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure Image2Click(Sender: TObject);
    procedure Image2DblClick(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseEnter(Sender: TObject);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Image2MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure Image2MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Image2MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Image3DblClick(Sender: TObject);
    procedure Image3MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Image4Click(Sender: TObject);
    procedure Image4DblClick(Sender: TObject);
    procedure Image4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Image4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure Image4MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Image4MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);

    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ListBox2Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure ListBox3DblClick(Sender: TObject);
    procedure ListBox4Click(Sender: TObject);
    procedure ListBox4DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);


  private

  public

  end;

var
  i: Integer;
  Form1: TForm1;
  RunProgram: TProcess;
  slice_flag1,slice_flag2,slice_flag3:boolean; // Флаги для возможности выставления среза
  y1, y2, y3: Integer;                         // смещение при выставлении среза в трех проекциях
  angle1, angle2, angle3: Float;               // углы поворота при выставлении среза в трех проекциях, меняются при нажатии на cntrl на 10 градусов
  x_slice, y_slice, z_slice: Integer;
  angle_x, angle_y, angle_z: Float;
  Button:TMouseButton;                         // хранит нажатые на мыши клавиши(левая, правая кнопка, средняя кнопка)
  Slice_pos_file :TextFile;                    // файл со смещениями и углами поворота при выставлении срезов
  Slice_num_file:TextFile;                     // файл, который хранит количество срезов
  current_slice,num_of_slices: Integer;        // Номер текущего среза, общее число срезов
  Imagename : string;                          // Имя файла с необходимым фото
  rot_x, rot_y, rot_z : array [1..3] of array [1..3] of Float; //Rotation matrices

const
  ImageWidth = 480;
  ImageHeight = 600;
implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.ListBox4Click(Sender: TObject);
begin

end;

procedure TForm1.ListBox4DblClick(Sender: TObject);     // вызов подпрограммы по двойному щелчку элемента списка

begin
RunProgram := TProcess.Create(nil);
RunProgram.CommandLine := 'guiGRE.exe';
RunProgram.Execute;
RunProgram.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  inif: TIniFile;
  x_ini, y_ini, w_ini, h_ini : Integer;
begin
  inif := TIniFile.Create('conf.ini');
  x_ini := inif.ReadInteger('Position', 'X', 0);
  y_ini := inif.ReadInteger('Position', 'Y', 0);
  w_ini := inif.ReadInteger('Size', 'W', 0);
  h_ini := inif.ReadInteger('Size', 'H', 0);
  Form1.Left:=x_ini;
  Form1.Top:=y_ini;
  Form1.Width:=w_ini;
  Form1.Height:=h_ini;

end;



procedure TForm1.Button7Click(Sender: TObject);            // Добавление нового протокола в текущее исследование
begin
     if  Listbox3.ItemIndex>-1  then
     Listbox4.Items.Add(Listbox3.Items.Strings[Listbox3.ItemIndex]);
end;

procedure TForm1.Button8Click(Sender: TObject);            // Удаление элемента из списка протоколов
begin
   if (ListBox4.ItemIndex > -1) then
        ListBox4.Items.Delete(ListBox4.ItemIndex);
end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin

end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin

end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TForm1.Image2Click(Sender: TObject);
begin

end;

procedure TForm1.Image2DblClick(Sender: TObject);
begin
  slice_flag2 := false;
end;

procedure TForm1.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TForm1.Image2MouseEnter(Sender: TObject);
begin


end;

procedure TForm1.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,  // Выставление среза в первой плоскости при движении мыши по картинке
  Y: Integer);
begin

  if (slice_flag2) then begin
  Form1.Image2.Picture.Bitmap.Canvas.clear;
  Imagename := 'MRI_test_' + IntToStr(current_slice)+'_'+'0'+'.png';
  image2.Picture.LoadFromFile(Imagename);
  Form1.Image2.Picture.Bitmap.Canvas.line(0,round(ImageHeight/2)+z_slice - round(ImageWidth/2*tan(angle_y)),ImageWidth,round(ImageHeight/2)+z_slice+round(ImageWidth/2*tan(angle_y)));

  end;

  if (ssCtrl in Shift) then begin
  angle_y := angle_y-3.14159/18;
  rot_y[1][1] := Cos(angle_y);
  rot_y[3][3] := Cos(angle_y);
  rot_y[1][3] := Sin(angle_y);
  rot_y[3][1] := -Sin(angle_y);
  // добавление угла 10 градусов по часовой стрелке
  end;

end;

procedure TForm1.Image2MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin




end;

procedure TForm1.Image2MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  z_slice := z_slice+5;
  if (slice_flag2) then begin
  Form1.Image4.Picture.Bitmap.Canvas.clear;
  Imagename := 'MRI_test_' + IntToStr(current_slice)+'_'+'0'+'.png';
  image4.Picture.LoadFromFile(Imagename);
  Form1.Image4.Picture.Bitmap.Canvas.line(0,round(ImageHeight/2)+z_slice - round(ImageWidth/2*tan(angle_y)),ImageWidth,round(ImageHeight/2)+z_slice+round(ImageWidth/2*tan(angle_y)));

end;
end;

procedure TForm1.Image2MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  z_slice := z_slice-5;
  if (slice_flag1) then begin
  Form1.Image2.Picture.Bitmap.Canvas.clear;
  Imagename := 'MRI_test_' + IntToStr(current_slice)+'_'+'0'+'.png';
  image2.Picture.LoadFromFile(Imagename);
  Form1.Image2.Picture.Bitmap.Canvas.line(0,round(ImageHeight/2)+z_slice - round(ImageWidth/2*tan(angle_y)),ImageWidth,round(ImageHeight/2)+z_slice+round(ImageWidth/2*tan(angle_y)));

end;
end;

procedure TForm1.Image3DblClick(Sender: TObject);
begin
  slice_flag3 := false;     // Блокирование выставления среза при двойном нажатии на картинку
end;



procedure TForm1.Image3MouseMove(Sender: TObject; Shift: TShiftState; X,       // Выставление среза во второй плоскости при движении мыши по картинке
  Y: Integer);
begin
  if (slice_flag3) then begin
  Form1.Image3.Picture.Bitmap.Canvas.clear;
  Imagename := 'MRI_test_' + IntToStr(current_slice)+'_'+'2'+'.png';
  image3.Picture.LoadFromFile(Imagename);
  Form1.Image3.Picture.Bitmap.Canvas.line(0,Mouse.CursorPos.Y - round(ImageWidth/2*tan(angle_z)),ImageWidth,Mouse.CursorPos.Y+round(ImageWidth/2*tan(angle_z)));
  y3 := Mouse.CursorPos.Y;

  if (ssCtrl in Shift) then begin
  angle_z := angle_z-3.14159/18;
  rot_z[1][1] := Cos(angle_z);
  rot_z[2][2] := Cos(angle_z);
  rot_z[1][2] := Sin(angle_z);
  rot_z[2][1] := -Sin(angle_z);
  end;
  end;
end;


procedure TForm1.Image4Click(Sender: TObject);
begin

end;

procedure TForm1.Image4DblClick(Sender: TObject);
begin
  slice_flag1:= false;
end;

procedure TForm1.Image4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TForm1.Image4MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (slice_flag1) then begin

  if (ssCtrl in Shift) then begin
  angle_x := angle_x-3.14159/18;
  rot_x[2][2] := Cos(angle_x);
  rot_x[3][3] := Cos(angle_x);
  rot_x[2][3] := -Sin(angle_x);
  rot_x[3][2] := Sin(angle_x);
  end;
  Form1.Image4.Picture.Bitmap.Canvas.clear;
  Imagename := 'MRI_test_' + IntToStr(current_slice)+'_'+'0'+'.png';
  image4.Picture.LoadFromFile(Imagename);
  Form1.Image4.Picture.Bitmap.Canvas.line(0,round(ImageHeight/2)+z_slice - round(ImageWidth/2*tan(angle_x)),ImageWidth,round(ImageHeight/2)+z_slice+round(ImageWidth/2*tan(angle_x)));
end;

end;

procedure TForm1.Image4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TForm1.Image4MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TForm1.Image4MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin


  if (slice_flag1) then begin
  z_slice := z_slice+5;
  Form1.Image4.Picture.Bitmap.Canvas.clear;
  Imagename := 'MRI_test_' + IntToStr(current_slice)+'_'+'0'+'.png';
  image4.Picture.LoadFromFile(Imagename);
  Form1.Image4.Picture.Bitmap.Canvas.line(0,round(ImageHeight/2)+z_slice - round(ImageWidth/2*tan(angle_x)),ImageWidth,round(ImageHeight/2)+z_slice+round(ImageWidth/2*tan(angle_x)));

end;

end;

procedure TForm1.Image4MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  z_slice := z_slice-5;
  if (slice_flag1) then begin
  Form1.Image4.Picture.Bitmap.Canvas.clear;
  Imagename := 'MRI_test_' + IntToStr(current_slice)+'_'+'0'+'.png';
  image4.Picture.LoadFromFile(Imagename);
  Form1.Image4.Picture.Bitmap.Canvas.line(0,round(ImageHeight/2)+z_slice - round(ImageWidth/2*tan(angle_x)),ImageWidth,round(ImageHeight/2)+z_slice+round(ImageWidth/2*tan(angle_x)));

end;

end;



procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin

end;

procedure TForm1.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TForm1.ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TForm1.ListBox1MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TForm1.ListBox2Click(Sender: TObject);
begin

end;

procedure TForm1.ListBox3Click(Sender: TObject);
begin

end;

procedure TForm1.ListBox3DblClick(Sender: TObject);
begin

end;

procedure TForm1.Button3Click(Sender: TObject);      // Первоначальное отображение плоскостей и срезов
begin
  Listbox4.clear;
  Listbox1.ItemIndex:=0;
  Listbox2.ItemIndex:=0;

  angle1 :=0;
  angle2 :=0;
  angle3 :=0;
  angle_x := 0;
  angle_z := 0;
  angle_y := 0;
  Imagename := 'MRI_test_' + IntToStr(current_slice)+'_'+'0'+'.png';
  Form1.Image4.Picture.Bitmap.Canvas.clear;
  image4.Picture.LoadFromFile(Imagename);
  Form1.Image4.Picture.Bitmap.Canvas.line(0,round(ImageHeight/2),ImageWidth,round(ImageHeight/2));
  slice_flag1 := true;

  Imagename := 'MRI_test_' + IntToStr(current_slice)+'_'+'1'+'.png';
  Form1.Image2.Picture.Bitmap.Canvas.clear;
  image2.Picture.LoadFromFile(Imagename);
  Form1.Image2.Picture.Bitmap.Canvas.line(0,round(ImageHeight/2),ImageWidth,round(ImageHeight/2));
  slice_flag2 := true;

  Imagename := 'MRI_test_' + IntToStr(current_slice)+'_'+'2'+'.png';
  Form1.Image3.Picture.Bitmap.Canvas.clear;
  image3.Picture.LoadFromFile(Imagename);
  Form1.Image3.Picture.Bitmap.Canvas.line(0,round(ImageHeight/2),ImageWidth,round(ImageHeight/2));
  slice_flag3 := true;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Listbox4.ItemIndex:=Listbox4.ItemIndex+1;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     rot_z[3][3]:=1;
     rot_x[1][1]:=1;
     rot_y[2][2]:=1;
     rot_x[2][2]:=1;
     rot_x[3][3]:=1;
     rot_y[2][2]:=1;
     rot_y[3][3]:=1;
     rot_z[2][2]:=1;
     rot_z[3][3]:=1;
     Imagename := 'MRI_test_' + IntToStr(current_slice)+'_'+'0'+'.png';
     image4.Picture.LoadFromFile(Imagename);
     Imagename := 'MRI_test_' + IntToStr(current_slice)+'_'+'1'+'.png';
     image2.Picture.LoadFromFile(Imagename);
     Imagename := 'MRI_test_' + IntToStr(current_slice)+'_'+'2'+'.png';
     image3.Picture.LoadFromFile(Imagename);
     slice_flag1 := true;
     slice_flag2 := true;
     slice_flag3 := true;
     Form1.Image4.Picture.Bitmap.Canvas.line(0,round(ImageHeight/2),ImageWidth,round(ImageHeight/2));
     Image2.Picture.Bitmap.Canvas.line(0,round(ImageHeight/2),ImageWidth,round(ImageHeight/2));
     Image3.Picture.Bitmap.Canvas.line(0,round(ImageHeight/2),ImageWidth,round(ImageHeight/2));
     Assignfile(Slice_num_file,'Slice_num_file.txt');
     try
       reset(Slice_num_file);
       readln(Slice_num_file,num_of_slices);
     finally
            CloseFile(Slice_num_file);
end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Assignfile(Slice_pos_file,'Slice_pos_file.txt');
  try
    rewrite(Slice_pos_file);  // для бесконечной записи в файл используй reset
    append(Slice_pos_file);
    writeln(Slice_pos_file,'Номер среза' , ' ', 'Проекция',' ','Смещение по Y',' ', 'Градус поворота');
    writeln(Slice_pos_file,current_slice , '             ', '1', '            ',y1,'         ',-RadToDeg(angle1));
    writeln(Slice_pos_file,current_slice , '             ', '2', '            ', y2, '         ',-RadToDeg(angle2));
    writeln(Slice_pos_file,current_slice , '             ', '3', '            ',y3, '         ',-RadToDeg(angle3));
    writeln(Slice_pos_file,current_slice , ' X ', 'rotation');
    for i:=1 to 3 do
          writeln(Slice_pos_file, rot_x[i][1],rot_x[i][2],rot_x[i][3]);
    writeln(Slice_pos_file,current_slice , ' Y ', 'rotation');
    for i:=1 to 3 do
          writeln(Slice_pos_file, rot_y[i][1],rot_y[i][2],rot_y[i][3]);
    writeln(Slice_pos_file,current_slice , ' Z ', 'rotation');
    for i:=1 to 3 do
          writeln(Slice_pos_file, rot_z[i][1],rot_z[i][2],rot_z[i][3]);
  finally
    CloseFile(Slice_pos_file);
  end;
end;


end.

