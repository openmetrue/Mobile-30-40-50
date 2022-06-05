//
//  ContentView.swift
//  dd
//
//  Created by Mark Khmelnitskii on 05.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var stories: [Story] = [
        Story(imagesName: "Istanbul-Turkey", cityName: "Стамбул, Tурция", date: "4 апреля", title: "", about: "", link: ""),
        Story(imagesName: "Moscow-Russia", cityName: "Москва, Россия", date: "17 августа", title: "", about: "", link: ""),
        Story(imagesName: "Oslo-Norway", cityName: "Осло, Норвегия", date: "27 февраля", title: "", about: "", link: ""),
        Story(imagesName: "Tokio-Japan", cityName: "Токио, Япония", date: "1 июля", title: "", about: "", link: ""),
        Story(imagesName: "Washington-USA", cityName: "Вашингтон, США", date: "12 ноября", title: "", about: "", link: "")
    ]
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var timerProgress: CGFloat = 0
    @State private var offset: CGFloat = 0
    var body: some View {
        GeometryReader { proxy in
            let index = getCurrentIndex()
            ZStack {
                ForEach(stories, id: \.imagesName) { story in
                    if stories[index].imagesName == story.imagesName {
                        Group {
                            Image(story.imagesName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: proxy.size.width, height: proxy.size.height)
                            VisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
                                .ignoresSafeArea()
                        }
                        Image(story.imagesName)
                            .resizable()
                            .scaledToFit()
                            .offset(x: offset, y: 0)
                            .transition(.slide)
                        VStack(spacing: 0) {
                            Text(story.cityName)
                                .fontWeight(.medium)
                                .padding(4)
                            Text(story.date)
                                .font(.subheadline)
                            Spacer()
                        }
                        .foregroundColor(Color.white)
                        .padding(16)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay(
                HStack {
                    Rectangle()
                        .fill(.black.opacity(0.01))
                        .onTapGesture {
                            tapPreviousStory()
                        }
                    
                    Rectangle()
                        .fill(.black.opacity(0.01))
                        .onTapGesture {
                            tapNextStory()
                        }
                }
            )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation {
                            offset = value.translation.width
                        }
                    }
                    .onEnded { value in
                        if offset < 0 {
                            tapNextStory()
                        } else {
                            tapPreviousStory()
                        }
                        offset = 0
                    }
            )
            .overlay(
                HStack(spacing: 0) {
                    ForEach(stories.indices, id: \.self) { index in
                        LoadingBar(progress: timerProgress, index: index)
                            .padding(.horizontal, 1)
                    }
                }
                    .padding(.horizontal), alignment: .top)
        }
        .onAppear(perform: {
            resetProgress()
        })
        .onReceive(timer) { _ in
            startProgress()
        }
    }
    
}

extension ContentView {
    private func resetProgress() {
        timerProgress = 0
    }
    private func startProgress() {
        if timerProgress < CGFloat(stories.count) {
            getProgressBarFrame(duration: 5)
        } else {
            resetProgress()
        }
    }
    
    private func tapNextStory() {
        if (timerProgress + 1) > CGFloat(stories.count) {
            resetProgress()
        } else {
            timerProgress = CGFloat(Int(timerProgress + 1))
        }
    }
    private func tapPreviousStory() {
        if (timerProgress - 1) < 0 {
            resetProgress()
        } else {
            timerProgress = CGFloat(Int(timerProgress - 1))
        }
    }
    
    private func getProgressBarFrame(duration: Double) {
        let calculatedDuration = duration * 0.1
        timerProgress += (0.01 / calculatedDuration)
    }
    
    private func getCurrentIndex() -> Int {
        return min(Int(timerProgress), stories.count - 1)
    }
}
