import SwiftUI
import Firebase
import GoogleSignIn

struct UserView: View {
    
    @State var shouldShowImagePicker = false
    @State var image:UIImage?
    @State var introduce: String = ""
    @AppStorage("log_Status") var log_Status = false
    @State var user = Auth.auth().currentUser
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    ZStack(alignment: .top){
                        Rectangle()
                            .foregroundColor(Color.indigo)
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: 100)
                        
                        Button{
                            shouldShowImagePicker.toggle()
                        }label: {
                            VStack{
                                if let image = self.image{
                                    Image(uiImage:image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 150)
                                        .cornerRadius(80)
                                }else{
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 50))
                                        .padding()
                                        .foregroundColor(.white)
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius:  80).stroke(Color.white, lineWidth: 3))
                        }
                    }
                }
                VStack(spacing: 15){
                    VStack(spacing: 5){
                        Text(user?.displayName ?? "SWU")
                            .bold()
                            .font(.title)
                        Text("국내 여행자")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }.padding()
                    TextField("자기 소개를 적어보세요 :)", text : $introduce)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                }
                Spacer()
                
                VStack(spacing: 15){
                    Button("로그아웃"){
                        GIDSignIn.sharedInstance.signOut()
                        try? Auth.auth().signOut()
                        
                        withAnimation{
                            log_Status = false
                        }
                    }
                    .padding(10)
                }
                Spacer()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil){
            ImagePicker(image: $image)
                .ignoresSafeArea()
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}

struct ImagePicker:UIViewControllerRepresentable{
    @Binding var image:UIImage?
    
    private let controller = UIImagePickerController()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator:NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
        let parent:ImagePicker
        
        init(parent:ImagePicker){
            self.parent = parent
        }
        
        func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]){
            parent.image = info[.originalImage] as? UIImage
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
