import SwiftUI

struct ExpenseView: View {
    @StateObject var expenseViewModel:ExpenseViewModel = .init()
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing : 12){
                    HStack(spacing: 15){
                        VStack(alignment: .leading, spacing: 10){
                        Text("지출 내역")
                                .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment:.leading)
                
                        NavigationLink(
                            destination: FilteredDetailView()
                                .environmentObject(expenseViewModel),
                            label: {
                                Image(systemName: "plus.magnifyingglass")
                                    .foregroundColor(.gray)
                                    .overlay(content: {
                                        Circle()
                                            .stroke(.white, lineWidth: 2)
                                            .padding(7)
                                    })
                                    .frame(width: 40, height: 40)
                                    .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                            })
                    }
                    ExpenseCard()
                        .environmentObject(expenseViewModel)
                    TransactionView()
                }
                .navigationBarHidden(true)
                .padding()
            }
            .background(){
                Color("BG")
                    .ignoresSafeArea()
            }
            .fullScreenCover(isPresented: $expenseViewModel.addNewExpense){
                expenseViewModel.clearData()
            } content: {
                NewExpense()
                    .environmentObject(expenseViewModel)
            }
            .overlay(alignment: .bottomTrailing){
                AddButton()
            }
        }
    }
    
    // Add New Expense Button
    @ViewBuilder
    func AddButton()->some View{
        Button{
            expenseViewModel.addNewExpense.toggle()
        }label: {
            Image(systemName: "plus")
                .foregroundColor(Color("white"))
                .font(.system(size: 25, weight: .medium))
                .frame(width: 55, height: 55)
                .background{
                    Circle()
                        .fill(
                            .linearGradient(colors:[
                                Color("Gradient2")
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
        }
        .padding()
    }
    
    @ViewBuilder
    func TransactionView()->some View{
        VStack(spacing: 15){
            Text("거래 내역")
                .font(.title2.bold())
                .opacity(0.7)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            
            ForEach(expenseViewModel.expenses){ expense in
                TransactionCardView(expense: expense)
                    .environmentObject(expenseViewModel)
            }
        }
        .padding(.top)
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
            ExpenseView()
    }
}
