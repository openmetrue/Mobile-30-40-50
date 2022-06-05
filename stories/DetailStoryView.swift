//
//  DetailStoryView.swift
//  stories
//
//  Created by Mark Khmelnitskii on 05.06.2022.
//

import SwiftUI

struct DetailStoryView: ViewModifier {
    @Binding var startingOffsetY: CGFloat
    @Binding var currentDragOffsetY: CGFloat
    @Binding var endingOffsetY: CGFloat
    @Binding var isOpenDetail: Bool
    
    let story: Story
    
    func body(content: Content) -> some View {
        ZStack {
            content
            DetailView(story: story, isOpen: $isOpenDetail)
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
        }
    }
}

struct DetailView: View {
    let story: Story
    @Binding var isOpen: Bool
    var body: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
                .ignoresSafeArea()
                .opacity(isOpen ? 1 : 0.01)
            VStack(spacing: 5) {
                Image(systemName: "chevron.up")
                    .padding(.top)
                    .foregroundColor(Color.white)
                    .rotationEffect(isOpen ? .degrees(180) : .zero)
                Text("Подробнее")
                    .foregroundColor(Color.white)
                    .fontWeight(.semibold)
                    .padding(12)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(16)
                
                Text(story.about)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.white)
                    .shadow(color: .black, radius: 1, x: 1, y: 1)
                    .padding(20)
                    .padding(.top, 20)
                if let url = URL(string: story.link) {
                    Link("Википедия", destination: url)
                        .buttonStyle(.automatic)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .cornerRadius(30)
        }
    }
}
