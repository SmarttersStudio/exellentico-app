
///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/15/2020 1:16 PM
///

class MyFormValidators{

    static validateEmpty(String data){
        if(data.isNotEmpty){
            return null;
        }else{
            return "Field can't be empty";
        }
    }
    static validateName({String name, int type}){
        if(name.isEmpty && type==1){
            return "First Name Can't be empty";
        }else if(name.isEmpty && type==2){
            return "Last Name Can't be empty";
        }else if(name.isEmpty && type==3){
            return "User Name Can't be empty";
        }else if(!RegExp('[a-zA-Z]').hasMatch(name)){
            return "Invalid name";
        }else{
            return null;
        }
    }
    static validateMail(String email){
        if(email.isEmpty){
            return "Email can't be empty";
        }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
            return "Invalid email id";
        }else{
            return null;
        }
    }
    static validatePhone(String phone){
        if(phone.isEmpty){
            return "Phone number can't be empty";
        }else if(!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(phone)){
            return "Invalid phone number";
        }else{
            return null;
        }
    }
    static validatePassword({String password,bool isConfirmPassword=false}){
        if(password.isEmpty && isConfirmPassword){
            return "Confirm Password can't be empty";
        }else if(password.isEmpty && !isConfirmPassword){
            return "Password can't be empty";
        }else if(password.length < 8){
            return "Password must be atleast 8 chars long";
        }else{
            return null;
        }
    }


}