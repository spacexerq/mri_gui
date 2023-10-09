unit first_block;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, second_block, patient_details;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Preregister: TButton;
    Exam: TButton;
    Search: TButton;
    Cancel: TButton;
    Help: TButton;
    additional_info_: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    weight_: TLabel;
    patient_lastname: TEdit;
    Label1: TLabel;
    patient_first_name: TEdit;
    Title: TEdit;
    Patient_ID: TEdit;
    Date_of_birth: TEdit;
    patient_lastname5: TEdit;
    patient_lastname6: TEdit;
    weight: TEdit;
    additional_info: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    procedure Button1ChangeBounds(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);

    procedure Label13Click(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure Label27Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure patient_lastnameChange(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.patient_lastnameChange(Sender: TObject);
begin

end;

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin

end;

procedure TForm1.ListBox2Click(Sender: TObject);
begin

end;

procedure TForm1.ListBox3Click(Sender: TObject);
begin

end;

procedure TForm1.Label13Click(Sender: TObject);
begin

end;

procedure TForm1.CancelClick(Sender: TObject);
var
  i:integer;
begin
for i:=0 to Form1.ComponentCount-1 do
  if (Form1.Components[i] is TEdit) then TEdit(Form1.Components[i]).Text:='';
end;
procedure TForm1.Button1ChangeBounds(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   Form3.ShowModal;
end;

procedure TForm1.HelpClick(Sender: TObject);
begin
  Form2.ShowModal;
end;





procedure TForm1.Label16Click(Sender: TObject);
begin

end;

procedure TForm1.Label27Click(Sender: TObject);
begin

end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.Memo1Change(Sender: TObject);
begin

end;

procedure TForm1.Panel1Click(Sender: TObject);
begin

end;

end.

