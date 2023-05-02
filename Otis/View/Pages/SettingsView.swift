import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var env: GlobalEnvironment
    @State var showPrivacy: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: false){
                LazyVStack(spacing: 15){
                    Text("Einstellungen")
                        .font(isMacOS() ? . system(size: 33, weight: .bold) : .largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                    
                    VStack(spacing: 15) {
                        VStack {
                            Section(header: Text("Design").font(.title2.bold()), content: {
                                AppearanceView(env: _env)
                                    .padding()
                            })
                                .padding(.horizontal, isBigDevice() ? isIOS() ? 200 : 80 : 0)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Blue"))
                        .cornerRadius(12)
                        
                        VStack(spacing: 15) {
                            VStack {
                                Section(header: Text("Kurse").font(.title2.bold()), content: {
                                    Picker(selection: $env.currentCourse, label: Text("Kurs"), content: {
                                        Text("Latein")
                                            .foregroundColor(Color("Main"))
                                            .tag(0)
                                        
                                        Text("English")
                                            .foregroundColor(Color("Main"))
                                            .tag(1)
                                    })
                                    #if os(macOS)
                                        .pickerStyle(PopUpButtonPickerStyle())
                                    #else
                                        .pickerStyle(SegmentedPickerStyle())
                                    #endif
                                })
                                    .padding(.horizontal, isBigDevice() ? isIOS() ? 200 : 80 : 0)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("Blue"))
                            .cornerRadius(12)
                            
                            Divider()
                            
                            VStack {
                                Section(header: Text("Lernen").font(.title2.bold()), content: {
                                    Picker(selection: $env.settings.studyType, label: Text("Fragestellung"), content: {
                                        Text("Vokabel - Übersetzung")
                                            .tag(StudyType.VocableToTranslation)
                                        
                                        Text("Übersetzung - Vokabel")
                                            .tag(StudyType.TranslationToVocable)
                                    })
                                    #if os(macOS)
                                        .pickerStyle(PopUpButtonPickerStyle())
                                    #else
                                        .pickerStyle(SegmentedPickerStyle())
                                    #endif
                                    
                                    Toggle(isOn: $env.settings.autoCorrection){
                                        Text("Autokorrektur")
                                    }
                                })
                                    .padding(.horizontal, isBigDevice() ? isIOS() ? 200 : 80 : 0)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("Blue"))
                            .cornerRadius(12)
                            
                            Divider()
                            
                            VStack {
                                Section(header: Text("Privacy Policy - in English").font(.title2.bold()), content: {
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack {
                                            Text(showPrivacy ? "Last updated: December 05, 2021" : "Last updated: ...")
                                                .foregroundColor(Color("Main"))
                                                .font(.title3)
                                            
                                            Spacer()
                                            
                                            Button {
                                                showPrivacy.toggle()
                                            } label: {
                                                if showPrivacy {
                                                    Image(systemName: "xmark")
                                                        .resizable()
                                                        .frame(width: 15, height: 15, alignment: .trailing)
                                                        .foregroundColor(Color("Main"))
                                                } else {
                                                    Text("Show")
                                                        .font(.title3)
                                                        .foregroundColor(Color("Main"))
                                                }
                                            }
                                        }
                                        
                                        if showPrivacy {
                                            Text("This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Interpretation and Definitions")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Interpretation")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("he words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Definitions")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("For the purposes of this Privacy Policy")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Account –  means a unique account created for You to access our Service or parts of our Service.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Affiliate – means an entity that controls, is controlled by or is under common control with a party, where control means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                        }
                                        
                                        if showPrivacy {
                                            Text("Application – means the software program provided by the Company downloaded by You on any electronic device, named Otis")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Company – (referred to as either the Company, We, Us or Our in this Agreement) refers to Otis.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Country – refers to: Austria")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Device – means any device that can access the Service such as a computer, a cellphone or a digital tablet.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Personal Data – is any information that relates to an identified or identifiable individual.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Service – refers to the Application.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Service Provider – means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Usage Data – refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit).")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("You – means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Collecting and Using Your Personal Data")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                        }
                                        
                                        if showPrivacy {
                                            Text("Collecting and Using Your Personal Data")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Types of Data Collected")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Personal Data")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Usage Data")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Usage Data is collected automatically when using the Service.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Usage Data may include information such as Your Device's Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("When You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("We may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Use of Your Personal Data")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                        }
                                        
                                        if showPrivacy {
                                            Text("The Company may use Personal Data for the following purposes:")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("To provide and maintain our Service, including to monitor the usage of our Service.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("To manage Your Account: to manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("For the performance of a contract: the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("To contact You: To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile application's push notifications regarding updates or informative communications related to the functionalities, products or contracted services, including the security updates, when necessary or reasonable for their implementation.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("To provide You with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless You have opted not to receive such information.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("To manage Your requests: To attend and manage Your requests to Us.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("For business transfers: We may use Your information to evaluate or conduct a merger, divestiture, restructuring, reorganization, dissolution, or other sale or transfer of some or all of Our assets, whether as a going concern or as part of bankruptcy, liquidation, or similar proceeding, in which Personal Data held by Us about our Service users is among the assets transferred.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("For other purposes: We may use Your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our Service, products, services, marketing and your experience.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("We may share Your personal information in the following situations:")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                        }
                                        
                                        if showPrivacy {
                                            Text("With Service Providers: We may share Your personal information with Service Providers to monitor and analyze the use of our Service,  to contact You.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("For business transfers: We may share or transfer Your personal information in connection with, or during negotiations of, any merger, sale of Company assets, financing, or acquisition of all or a portion of Our business to another company.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("With Affiliates: We may share Your information with Our affiliates, in which case we will require those affiliates to honor this Privacy Policy. Affiliates include Our parent company and any other subsidiaries, joint venture partners or other companies that We control or that are under common control with Us.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("With business partners: We may share Your information with Our business partners to offer You certain products, services or promotions.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("With other users: when You share personal information or otherwise interact in the public areas with other users, such information may be viewed by all users and may be publicly distributed outside.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("With Your consent: We may disclose Your personal information for any other purpose with Your consent.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Retention of Your Personal Data")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("he Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Transfer of Your Personal Data")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                        }
                                        
                                        if showPrivacy {
                                            Text("Your information, including Personal Data, is processed at the Company's operating offices and in any other places where the parties involved in the processing are located. It means that this information may be transferred to — and maintained on — computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from Your jurisdiction.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Your consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("The Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of Your data and other personal information.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Disclosure of Your Personal Data")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Business Transactions")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Law enforcement")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Other legal requirements")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                        }
                                        
                                        if showPrivacy {
                                            Text("Comply with a legal obligation")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Protect and defend the rights or property of the Company")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Prevent or investigate possible wrongdoing in connection with the Service")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Protect the personal safety of Users of the Service or the public")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Protect against legal liability")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Security of Your Personal Data")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Children's Privacy")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent's consent before We collect and use that information.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                        }
                                        
                                        if showPrivacy {
                                            Text("Links to Other Websites")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party's site. We strongly advise You to review the Privacy Policy of every site You visit.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Changes to this Privacy Policy")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the Last updated date at the top of this Privacy Policy.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("Contact Us")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("If you have any questions about this Privacy Policy, You can contact us:")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                            
                                            Text("By email: support@etotis.com")
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("Main"))
                                                .padding()
                                                .background(Color("Main1").opacity(0.2))
                                                .cornerRadius(12)
                                        }
                                    }
                                    .padding(.top, 10)
                                    .padding(.horizontal)
                                })
                                    .padding(.horizontal, isBigDevice() ? isIOS() ? 200 : 80 : 0)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("Blue"))
                            .cornerRadius(12)
                            
                            Divider()
                            
                            VStack {
                                Section(header: Text("Credits").font(.title2.bold()), content: {
                                   Text("Entwickler: Clemens Sageder")
                                        .foregroundColor(Color("Main"))
                                        .padding(.top, 10)
                                })
                                    .padding(.horizontal, isBigDevice() ? isIOS() ? 200 : 80 : 0)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("Blue"))
                            .cornerRadius(12)
                        }
                        .padding(.top, 30)
                        .padding(.bottom, isMacOS() ? 20 : 60)
                    }
                }
                .padding(.top, isMacOS() ? 45 : 30)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(env: EnvironmentObject<GlobalEnvironment>())
            .environmentObject(GlobalEnvironment())
    }
}
