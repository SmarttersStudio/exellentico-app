
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
    static validateName(String name){
        if(name.isEmpty){
            return "Name Can't be empty";
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
    static validatePassword(String password){
        if(password.isEmpty){
            return "Password can't be empty";
        }else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(password)){
            return "Invalid password";
        }else{
            return null;
        }
    }

}