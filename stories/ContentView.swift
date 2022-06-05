//
//  ContentView.swift
//  dd
//
//  Created by Mark Khmelnitskii on 05.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var stories: [Story] = [
        Story(imagesName: "Istanbul-Turkey", cityName: "Стамбул, Tурция", date: "4 апреля", title: "Ранее известный как Византий", about: "Ранее известный как Византий (греч. Βυζάντιον), затем Константинополь (греч. Κωνσταντινούπολις) — крупнейший город Турции, экономический, исторический и культурный центр страны. Расположен в Евразии, на берегах пролива Босфор (который разделяет Европу и Азию), между Мраморным и Чёрным морем. Европейская (основная) и азиатская части города соединены мостами и тоннелями. С населением свыше 15 млн человек, Стамбул является одним из самых населённых городов мира. Бывшая столица Римской, Восточно-Римской (Византийской), Латинской и Османской империй. Столицей Турции Стамбул не является. В 1923 году, после Войны за независимость Турции, Анкара стала новой турецкой столицей", link: "https://en.wikipedia.org/wiki/Istanbul"),
        Story(imagesName: "Moscow-Russia", cityName: "Москва, Россия", date: "17 августа", title: "Слезам не верит", about: "Столица России, город федерального значения, административный центр Центрального федерального округа и центр Московской области, в состав которой не входит. Крупнейший по численности населения город России и её субъект — 12 635 466[3] человек (2022), самый населённый из городов, полностью расположенных в Европе, занимает 22-е место среди городов мира по численности населения[7], крупнейший русскоязычный город в мире. Лучший мегаполис мира по качеству жизни и развитию инфраструктуры (оценка экспертов ООН, 2022)", link: "https://en.wikipedia.org/wiki/Moscow"),
        Story(imagesName: "Oslo-Norway", cityName: "Осло, Норвегия", date: "27 сентября", title: "Тут холодно", about: "Столица и самый крупный город Норвегии. До 1624 года, согласно карте А. Ортелиуса 1539 года столица викингов называлась Викия (Vichia), с 1624 по 1877 год называлась Христиания (норв. Christiania), с 1877 по 1925 год — Кристиания (норв. Kristiania)", link: "https://en.wikipedia.org/wiki/Oslo"),
        Story(imagesName: "Tokio-Japan", cityName: "Токио, Япония", date: "1 июля", title: "Здесь придумали Бурятские мультики", about: "Столица и крупнейший город Японии, её административный, финансовый, промышленный и политический центр. Крупнейшая городская экономика мира[6]. Расположен в юго-восточной части острова Хонсю, на равнине Канто в бухте Токийского залива Тихого океана. Помимо столицы, Токио также является одной из сорока семи префектур страны. Площадь префектуры составляет 2188,67 км²[7], население — 14 064 696 человек (1 октября 2020)[8], плотность населения — 6426,14 чел./км². По состоянию на 1 августа 2021 года, население Токио составляло 14 043 239 человек, что делает Токио префектурой с самым большим населением в Японии", link: "https://en.wikipedia.org/wiki/Tokyo"),
        Story(imagesName: "Washington-USA", cityName: "Вашингтон, США", date: "12 ноября", title: "Сами придумайте шутку", about: "Город, столица Соединённых Штатов Америки. Официальное название — округ Колумбия (англ. District of Columbia, сокращённо D.C., «Ди-Си»). Чтобы не путать город с одноимённым штатом на северо-западе страны, американцы в разговорной речи обычно называют город «Ди-Си» или «Вашингтон, Ди-Си». Федеральный округ Колумбия является самостоятельной территорией, не входящей ни в один из штатов. Он был образован в 1790 году Актом о местопребывании и включал город Джорджтаун, а также город Александрию (до 1846 года). Город Вашингтон был основан в 1791 году и назван в честь Джорджа Вашингтона, первого американского президента. В 1871 году города Вашингтон и Джорджтаун и округ Вашингтон были формально упразднены как самостоятельные административные единицы и объединены с округом Колумбия", link: "https://en.wikipedia.org/wiki/Washington,_D.C.")
    ]
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var timerProgress: CGFloat = 0
    @State private var offset: CGFloat = 0
    @State private var isOpenDetail = false
    
    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.82
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var endingOffsetY: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            let index = getCurrentIndex()
            ZStack {
                ForEach(stories, id: \.imagesName) { story in
                    if stories[index].imagesName == story.imagesName {
                        Group {
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
                            VStack(alignment: .leading, spacing: 10) {
                                Spacer()
                                HStack {
                                    Text(story.title)
                                        .font(.title)
                                        .fontWeight(.medium)
                                        .shadow(color: .black, radius: 1, x: 1, y: 1)
                                        
                                    Spacer()
                                }
                                HStack {
                                    Text("Подборка для вас")
                                        .shadow(color: .black, radius: 0.5, x: 1, y: 1)
                                    Spacer()
                                }
                            }
                            .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                            .foregroundColor(Color.white)
                            .padding(16)
                        }
                        .modifier(DetailStoryView(startingOffsetY: $startingOffsetY, currentDragOffsetY: $currentDragOffsetY, endingOffsetY: $endingOffsetY, isOpenDetail: $isOpenDetail, story: story))
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
                .opacity(isOpenDetail ? 0 : 1)
            )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.location.y > UIScreen.main.bounds.height * 0.75 || isOpenDetail {
                            withAnimation(.spring()) {
                                isOpenDetail = true
                                currentDragOffsetY = value.translation.height
                            }
                        } else {
                            withAnimation {
                                offset = value.translation.width
                            }
                        }
                    }
                    .onEnded { value in
                        if !isOpenDetail {
                            if offset < 0 {
                                tapNextStory()
                            } else {
                                tapPreviousStory()
                            }
                            offset = 0
                        } else {
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    isOpenDetail = true
                                    endingOffsetY = -startingOffsetY
                                } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                    isOpenDetail = false
                                } else if endingOffsetY != 0 {
                                    isOpenDetail = true
                                } else {
                                    isOpenDetail = false
                                }
                                currentDragOffsetY = 0
                            }
                        }
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
            guard !isOpenDetail else { return }
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
