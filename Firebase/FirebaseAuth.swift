    private func createUserToFireAuth(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}

        Auth.auth().createUser(withEmail: email, password: password){(auth, err) in
            if let err = err{
                print("You cannot create New Account", err)
                return
            }
            guard let uid = auth?.user.uid else {return}
            self.setUserDataToFirestore(email:email, uid: uid)
        }
    }

    private func setUserDataToFirestore(email:String, uid: String){
        guard let name = nameTextField.text else {return}
        let document = [
            "name": name,
            "email": email,
            "createAt": Timestamp()
        ] as [String: Any]


        Firestore.firestore().collection("users").document(uid).setData(document){ err in
            if let err = err{
                print("You cannot save your account in FireStore", err)
                return
            }
            print("You success & save your account uid in FireStore")
        }
    }