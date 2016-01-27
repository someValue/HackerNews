//
//  StoryTableViewCell.swift
//  HackerNews
//
//  Created by Vohra, Nikant on 27/03/15.
//  Copyright (c) 2015 Vohra, Nikant. All rights reserved.
//

import UIKit
import libHN

protocol StoryTableViewCellDelegate: class {
    func storyTableViewCellDidTouchUpvote(cell: StoryCell, sender: AnyObject)
    func storyTableViewCellDidTouchComment(cell: StoryCell, sender: AnyObject)
    func storyTableViewCellDidTouchAuthorLabel(cell: StoryCell, sender:AnyObject)
}

class StoryCell: UITableViewCell {

    @IBOutlet weak var badgeImageView: AsyncImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var avatarImageView: AsyncImageView!
    @IBOutlet weak var authorLabel: UILabel!{
        didSet {
            let tapGestureRecognizer =  UITapGestureRecognizer(target: self, action: Selector("authorLabelTapped:"))
            tapGestureRecognizer.numberOfTapsRequired = 1;
            authorLabel.addGestureRecognizer(tapGestureRecognizer)
            authorLabel.userInteractionEnabled = true
            
        }
    }
    @IBOutlet weak var upvoteButton: SpringButton!
    @IBOutlet weak var commentButton: SpringButton!
    weak var delegate: StoryTableViewCellDelegate?
    @IBOutlet weak var commentTextView: AutoTextView!
    
    
    
    func authorLabelTapped(sender: AnyObject) {
        delegate?.storyTableViewCellDidTouchAuthorLabel(self, sender: sender)
    }
    
    
    func configureWithStory(story: HNPost?) {
        let title = story!.Title
        let author = story!.Username
        let voteCount = story!.Points
        let commentCount = story!.CommentCount
        let createdAt = story!.TimeCreatedString
       // let commentHTML = story["text"].string ?? ""
        
        authorLabel.text = author
        titleLabel.text = title
        commentButton.setTitle(String(commentCount), forState: UIControlState.Normal)
        upvoteButton.setTitle(String(voteCount), forState: UIControlState.Normal)
//        if let commentTextView = commentTextView {
//                        commentTextView.attributedText = htmlToAttributedString(commentHTML + "<style>*{font-family:\"Avenir Next\";font-size:16px;line-height:20px}img{max-width:300px}</style>")
//        }
//
        if let commentTextView = commentTextView {
            commentTextView.text = ""
        }
        
        // Find out if a post has been voted on
        if (HNManager.sharedManager().hasVotedOnObject(story)) {
            // User has voted on the Post/Comment
            upvoteButton.imageView?.image = UIImage(named: "icon-upvote-active")
        }
        else {
            upvoteButton.imageView?.image = UIImage(named: "icon-upvote")
        }
        timeLabel.text = createdAt
        
    }
    
    
    @IBAction func upvoteButtonDidTouch(sender: AnyObject) {
        upvoteButton.animation = "pop"
        upvoteButton.force = 3
        upvoteButton.animate()
        
        delegate?.storyTableViewCellDidTouchUpvote(self, sender: sender)
    }
    
    @IBAction func commentButtonDidTouch(sender: AnyObject) {
        commentButton.animation = "pop"
        commentButton.force = 3
        commentButton.animate()
        
        delegate?.storyTableViewCellDidTouchComment(self, sender: sender)
    }
}
