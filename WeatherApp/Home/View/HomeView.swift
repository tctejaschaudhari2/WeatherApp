//
//  HomeView.swift
//  WeatherApp
//
//  Created by tejas chaudhari on 20/12/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @AppStorage(ASKeys.searchQuery) private var searchQuery = ""
    
    var body: some View {
        VStack {
            // Search Bar
            HStack {
                TextField("", text: $homeViewModel.searchQuery)
                    .font(.customFont(.regular, 15))
                    .placeholder(when: homeViewModel.searchQuery.isEmpty) {
                        Text("Search Location")
                            .customFont(.regular, 15)
                            .foregroundStyle(.colorGray2)
                    }
                    .foregroundStyle(.colorTitle)
                    .padding(15)
                    .padding(.leading, 8)
                    .submitLabel(.search)
                    .searchable(text: $homeViewModel.searchQuery)
                    .onChange(of: homeViewModel.searchQuery){
                        homeViewModel.listenToSearch()
                    }
                    .onSubmit(of: .search) {
                        homeViewModel.fetchCurrentLocationWeather(searchQuery: homeViewModel.searchQuery)
                    }
                                
                Image(.icSearch)
                    .padding(.trailing, 20)
            }
            .background(Color(.systemGray6))
            .cornerRadius(16)
            .padding(.horizontal, 16)
            .padding(.top, 20)
            switch homeViewModel.state{
            case .idle:
                Spacer()
                
                // Center Text
                VStack(spacing: 8) {
                    Text("No City Selected")
                        .customFont(.semiBold, 30)
                        .foregroundStyle(.colorTitle)
                        .padding([.top, .leading, .trailing])
                    
                    Text("Please Search For A City")
                        .customFont(.semiBold, 15)
                        .foregroundStyle(.colorTitle)
                }.onAppear{
                    if searchQuery.isEmpty {
                        homeViewModel.listenToSearch()
                    } else {
                        homeViewModel.isCardTapped = true
                        homeViewModel.fetchCurrentLocationWeather(searchQuery: searchQuery)
                    }
                }
                
                Spacer()
                
            case .loading:
                
                Spacer()
                
                ProgressView()
                    .controlSize(.large)
                
                Spacer()
                
            case .failed(_ , _ ):
                Spacer()
                
                Text("")
                
            case .loaded(let weather):
                if homeViewModel.isCardTapped{
                    // Weather Icon and Temperature
                    Spacer()
                    
                    VStack(spacing: 10) {
                        weatherIconView(iconUrl: weather.current?.condition?.iconUrl ?? "")
                            .frame(width: 120, height: 120)
                        
                        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                            Text(weather.location?.name ?? "")
                                .customFont(.semiBold, 30)
                                .foregroundStyle(.colorTitle)
                            Image(.icArrow)
                        })
                        
                        Text("\(weather.current?.dispTemp ?? "0.0") °")
                            .customFont(.semiBold, 70)
                            .foregroundStyle(.colorTitle)
                    }
                    .padding(.bottom, 20)

                    // Additional Weather Details
                    HStack {
                        WeatherComponentView(label: "Humidity", value: "\(weather.current?.dispHumidity ?? "")%")
                        WeatherComponentView(label: "UV", value: "\(weather.current?.dispUV ?? "")")
                        WeatherComponentView(label: "Feels Like", value: "\(weather.current?.dispFeelsLike ?? "")°")
                    }
                    .frame(width: 274, height: 75)
                    .background(Color(.colorGray3))
                    .cornerRadius(16)
                    .padding(.horizontal)

                    Spacer()
                } else {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(weather.location?.name ?? "")")
                                .customFont(.semiBold, 20)
                            Text("\(weather.current?.dispTemp ?? "0.0") °")
                                .customFont(.semiBold, 60)
                        }
                        Spacer()
                        weatherIconView(iconUrl: weather.current?.condition?.iconUrl ?? "")
                            .frame(width: 120, height: 90)
                    }
                    .onTapGesture {
                        searchQuery = weather.location?.name ?? ""
                        homeViewModel.isCardTapped.toggle()
                    }
                    .padding()
                    .background(Color(.colorGray3))
                    .cornerRadius(16)
                    .padding()
                }
                
                Spacer()
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    HomeView(homeViewModel: HomeViewModel())
}

