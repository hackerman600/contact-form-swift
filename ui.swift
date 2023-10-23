import SwiftUI
    



struct ContactformView: View {
    
    @State var email : String = ""
    @State var first : String = ""
    @State var second : String = ""
    @State var subject : String = ""
    @State var bod : String = ""
    @State var seemessage = false
    
    //bod
    @State var text : String = ""
    
    //first check
    @State var empty_first = false
    
    //second chack
    @State var empty_second = false
    
    //email check
    @State var empty_email = false
    @State var domainname_err = false
    @State var hostname_err = false
    @State var dot_err = false
    
    //subject check
    @State var subject_limit = 30
    @State var empty_subject = false
    
    //body check
    @State var empty_bod = false
    @State var limit_bod = false
    var body_limit = 140
    
    
    //domain
    var my_emaill = my_email(emailad: "")
    
    var body: some View {
        
        
        ZStack{
            
            Text("RA").foregroundColor(Color("rblue")).font(.system(size: 30, weight: .semibold)).scaleEffect(x:2.5,y:1.25).position(x:120,y:20).underline(true, color: Color("rpink"))
            
            
            Text("contact form").font(.system(size: 30)).foregroundColor(Color("rblue")).offset(y:-200)
            
            TextField(" first name", text: $first)
                .frame(width:100,height:30)
                .padding(.vertical, 5).padding(.horizontal,10).background(Color("back_g")).cornerRadius(15).onChange(of:first){newValue in empty_first = false}.offset(x:-70, y:-135)
            
            TextField(" last name", text: $second)
                .frame(width:100,height:30)
                .padding(.vertical, 5).padding(.horizontal,10).onChange(of: second) {newValue in empty_second = false}.background(Color("back_g")).cornerRadius(15).offset(x:70, y:-135)
            
            
            TextField(" email",text: $email).autocapitalization(.none)
                    .frame(width:240,height:30)
                    .padding(.vertical, 5).padding(.horizontal,10).onChange(of: email) {newValue in empty_email = false; hostname_err = false; dot_err = false; domainname_err = false }.background(Color("back_g")).cornerRadius(15).offset(x:0,y:-70)
         
            
            TextField(" subject",text: $subject)
                    .frame(width:240,height:30)
                    .padding(.vertical, 5).padding(.horizontal,10).background(Color("back_g")).cornerRadius(15).offset(x:0,y:-5).onChange(of: subject){newValue in empty_subject = false
                        }
            
            
            Button("send message"){
                
                //check emails
                lazy var email_class = my_email(emailad: email)
                let full_email = email
                let host_dom_split = email_class.split_email(string: full_email, character: "@")
                let hostname = host_dom_split[0]
                let domain = host_dom_split[1]
                print("domain is: ", domain)
                
                let dots_status = email_class.check_dots(string: email)
                
                
            
                if first.count == 0 {
                    empty_first = true
                }
                
                else if second.count == 0 {
                    empty_second = true
                }
                
                else if email.count == 0 {
                    empty_email = true
                }
                
                else if hostname.count == 0 {
                    hostname_err = true
                }
                
                else if domain.count == 0 {
                    domainname_err = true
                }
                
                else if dots_status == 0 {
                    dot_err = true
                }
                
                else if subject.count == 0 {
                    empty_subject = true
                }
                
                else if bod.count == 0 {
                    empty_bod = true
                }
                
                else if bod.count > body_limit {
                    limit_bod = true
                }
                
                else {
                    seemessage = true
                }
                
                
                
            }.font(.system(size:20)).padding(.vertical, 11).padding(.horizontal, 60).background(Color("rblue")).foregroundColor(Color.white).cornerRadius(15).overlay(
                RoundedRectangle(cornerRadius: 15).stroke(Color("rpink"), lineWidth: 2)).offset(x:0,y:210)
            
            ZStack{
                TextEditor(text: $bod).onChange(of: bod){newValue in limit_bod = false; empty_bod = false}.frame(minWidth: 250, maxWidth:260, minHeight: 50, maxHeight: 100).border(Color("edge"), width: 5).cornerRadius(15).offset(x:0, y:90)
            }
            
            ZStack{
                if empty_first == true {
                    Text("use a first name").foregroundColor(Color.red).offset(x:-58,y:-105)
                }
                
                else if empty_second == true {
                    Text("use a last name").foregroundColor(Color.red).offset(x:82,y:-105)
                }
                
                else if empty_email == true {
                    Text("use an email").foregroundColor(Color.red).offset(x:-70,y:-40)
                }
                
                else if domainname_err == true {
                    Text("use a domain").foregroundColor(Color.red).offset(x:-70,y:-40)
                }
                
                else if hostname_err == true {
                    Text("use a hostname").foregroundColor(Color.red).offset(x:-70,y:-40)
                }
                
                else if dot_err == true {
                    Text("correct format - name@domain.com").foregroundColor(Color.red).offset(x:20,y:-40)
                }
                
                else if empty_subject == true {
                    Text("provide a subject").foregroundColor(Color.red).offset(x:-50,y:25)
                }
                
                else if empty_bod == true {
                    Text("input a message into the body").foregroundColor(Color.red).offset(x:0,y:150)
                }
                
                else if limit_bod == true {
                    Text("character limit of 140 reached").foregroundColor(Color.red).offset(x:-10,y:150)
                }
                
                else if seemessage == true {
                    callme()
                }
                
             
            }
            
        }
        
        
        
    }
    
    
}


struct callme: View {
    var body: some View {
        ZStack {
            Color.white
            messageSentView()
        }
.offset(x:0,y:0)
    }
}


struct ContactformView_Previews: PreviewProvider {
    static var previews: some View {
        ContactformView()
    }
}
