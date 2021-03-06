//
//  DemoBButtonVC.m
//  Application
//
//  Created by loufq on 14-6-4.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "DemoBButtonVC.h"
//////////////////////////////////////////////////////////////
/**
 *  SettingVCCell
 */
@interface DemoBButtonVCCell : BaseTableViewCell{

}@end
@implementation DemoBButtonVCCell

-(void)initLayout{
    [super initLayout];
    
}
-(void)updateAtIndex:(NSInteger)aIndex withInfo:(id)aEntity{
    [[self.contentView viewWithTag:1000] removeFromSuperview];
    self.textLabel.text= [aEntity valueForKey:@"name"];
    BButton* btn = ( BButton*)[aEntity valueForKey:@"btn"];
    btn.tag = 1000;
    btn.left = 270;
    [self.contentView addSubview:btn];
}
@end
//////////////////////////////////////////////////////////////
@interface DemoBButtonVC ()

@end

@implementation DemoBButtonVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"BButton List";
    NSMutableArray* list = [NSMutableArray array];
    NSArray* strings = [self getTitles];
    for ( int direction = FAIconGlass; direction <= FAIconShareSign; ++direction)
    {
        BButton* btn =[BButton awesomeButtonWithOnlyIcon:direction type:BButtonTypeDefault style:2];
        btn.frame = CGRectMake(0, 0, 44, 44);
        NSDictionary* dict = @{@"name": strings[direction],@"btn":btn};
        [list addObject:dict];
    }
    self.dataList = list;
    [self.tableView reloadData];
}

-(NSArray*)getTitles{
    return @[@"FAIconGlass",
             @"FAIconMusic",
             @"FAIconSearch",
             @"FAIconEnvelope",
             @"FAIconHeart",
             @"FAIconStar",
             @"FAIconStarEmpty",
             @"FAIconUser",
             @"FAIconFilm",
             @"FAIconThLarge",
             @"FAIconTh",
             @"FAIconThList",
             @"FAIconOk",
             @"FAIconRemove",
             @"FAIconZoomIn",
             @"FAIconZoomOut",
             @"FAIconOff",
             @"FAIconSignal",
             @"FAIconCog",
             @"FAIconTrash",
             @"FAIconHome",
             @"FAIconFile",
             @"FAIconTime",
             @"FAIconRoad",
             @"FAIconDownloadAlt",
             @"FAIconDownload",
             @"FAIconUpload",
             @"FAIconInbox",
             @"FAIconPlayCircle",
             @"FAIconRepeat",
             @"FAIconRefresh",
             @"FAIconListAlt",
             @"FAIconLock",
             @"FAIconFlag",
             @"FAIconHeadphones",
             @"FAIconVolumeOff",
             @"FAIconVolumeDown",
             @"FAIconVolumeUp",
             @"FAIconQrcode",
             @"FAIconBarcode",
             @"FAIconTag",
             @"FAIconTags",
             @"FAIconBook",
             @"FAIconBookmark",
             @"FAIconPrint",
             @"FAIconCamera",
             @"FAIconFont",
             @"FAIconBold",
             @"FAIconItalic",
             @"FAIconTextHeight",
             @"FAIconTextWidth",
             @"FAIconAlignLeft",
             @"FAIconAlignCenter",
             @"FAIconAlignRight",
             @"FAIconAlignJustify",
             @"FAIconList",
             @"FAIconIndentLeft",
             @"FAIconIndentRight",
             @"FAIconFacetimeVideo",
             @"FAIconPicture",
             @"FAIconPencil",
             @"FAIconMapMarker",
             @"FAIconAdjust",
             @"FAIconTint",
             @"FAIconEdit",
             @"FAIconShare",
             @"FAIconCheck",
             @"FAIconMove",
             @"FAIconStepBackward",
             @"FAIconFastBackward",
             @"FAIconBackward",
             @"FAIconPlay",
             @"FAIconPause",
             @"FAIconStop",
             @"FAIconForward",
             @"FAIconFastForward",
             @"FAIconStepForward",
             @"FAIconEject",
             @"FAIconChevronLeft",
             @"FAIconChevronRight",
             @"FAIconPlusSign",
             @"FAIconMinusSign",
             @"FAIconRemoveSign",
             @"FAIconOkSign",
             @"FAIconQuestionSign",
             @"FAIconInfoSign",
             @"FAIconScreenshot",
             @"FAIconRemoveCircle",
             @"FAIconOkCircle",
             @"FAIconBanCircle",
             @"FAIconArrowLeft",
             @"FAIconArrowRight",
             @"FAIconArrowUp",
             @"FAIconArrowDown",
             @"FAIconShareAlt",
             @"FAIconResizeFull",
             @"FAIconResizeSmall",
             @"FAIconPlus",
             @"FAIconMinus",
             @"FAIconAsterisk",
             @"FAIconExclamationSign",
             @"FAIconGift",
             @"FAIconLeaf",
             @"FAIconFire",
             @"FAIconEyeOpen",
             @"FAIconEyeClose",
             @"FAIconWarningSign",
             @"FAIconPlane",
             @"FAIconCalendar",
             @"FAIconRandom",
             @"FAIconComment",
             @"FAIconMagnet",
             @"FAIconChevronUp",
             @"FAIconChevronDown",
             @"FAIconRetweet",
             @"FAIconShoppingCart",
             @"FAIconFolderClose",
             @"FAIconFolderOpen",
             @"FAIconResizeVertical",
             @"FAIconResizeHorizontal",
             @"FAIconBarChart",
             @"FAIconTwitterSign",
             @"FAIconFacebookSign",
             @"FAIconCameraRetro",
             @"FAIconKey",
             @"FAIconCogs",
             @"FAIconComments",
             @"FAIconThumbsUp",
             @"FAIconThumbsDown",
             @"FAIconStarHalf",
             @"FAIconHeartEmpty",
             @"FAIconSignout",
             @"FAIconLinkedinSign",
             @"FAIconPushpin",
             @"FAIconExternalLink",
             @"FAIconSignin",
             @"FAIconTrophy",
             @"FAIconGithubSign",
             @"FAIconUploadAlt",
             @"FAIconLemon",
             @"FAIconPhone",
             @"FAIconCheckEmpty",
             @"FAIconBookmarkEmpty",
             @"FAIconPhoneSign",
             @"FAIconTwitter",
             @"FAIconFacebook",
             @"FAIconGithub",
             @"FAIconUnlock",
             @"FAIconCreditCard",
             @"FAIconRss",
             @"FAIconHdd",
             @"FAIconBullhorn",
             @"FAIconBell",
             @"FAIconCertificate",
             @"FAIconHandRight",
             @"FAIconHandLeft",
             @"FAIconHandUp",
             @"FAIconHandDown",
             @"FAIconCircleArrowLeft",
             @"FAIconCircleArrowRight",
             @"FAIconCircleArrowUp",
             @"FAIconCircleArrowDown",
             @"FAIconGlobe",
             @"FAIconWrench",
             @"FAIconTasks",
             @"FAIconFilter",
             @"FAIconBriefcase",
             @"FAIconFullscreen",
             @"FAIconGroup",
             @"FAIconLink",
             @"FAIconCloud",
             @"FAIconBeaker",
             @"FAIconCut",
             @"FAIconCopy",
             @"FAIconPaperClip",
             @"FAIconSave",
             @"FAIconSignBlank",
             @"FAIconReorder",
             @"FAIconListUl",
             @"FAIconListOl",
             @"FAIconStrikethrough",
             @"FAIconUnderline",
             @"FAIconTable",
             @"FAIconMagic",
             @"FAIconTruck",
             @"FAIconPinterest",
             @"FAIconPinterestSign",
             @"FAIconGooglePlusSign",
             @"FAIconGooglePlus",
             @"FAIconMoney",
             @"FAIconCaretDown",
             @"FAIconCaretUp",
             @"FAIconCaretLeft",
             @"FAIconCaretRight",
             @"FAIconColumns",
             @"FAIconSort",
             @"FAIconSortDown",
             @"FAIconSortUp",
             @"FAIconEnvelopeAlt",
             @"FAIconLinkedin",
             @"FAIconUndo",
             @"FAIconLegal",
             @"FAIconDashboard",
             @"FAIconCommentAlt",
             @"FAIconCommentsAlt",
             @"FAIconBolt",
             @"FAIconSitemap",
             @"FAIconUmbrella",
             @"FAIconPaste",
             @"FAIconLightBulb",
             @"FAIconExchange",
             @"FAIconCloudDownload",
             @"FAIconCloudUpload",
             @"FAIconUserMd",
             @"FAIconStethoscope",
             @"FAIconSuitecase",
             @"FAIconBellAlt",
             @"FAIconCoffee",
             @"FAIconFood",
             @"FAIconFileAlt",
             @"FAIconBuilding",
             @"FAIconHospital",
             @"FAIconAmbulance",
             @"FAIconMedkit",
             @"FAIconFighterJet",
             @"FAIconBeer",
             @"FAIconHSign",
             @"FAIconPlusSignAlt",
             @"FAIconDoubleAngleLeft",
             @"FAIconDoubleAngleRight",
             @"FAIconDoubleAngleUp",
             @"FAIconDoubleAngleDown",
             @"FAIconAngleLeft",
             @"FAIconAngleRight",
             @"FAIconAngleUp",
             @"FAIconAngleDown",
             @"FAIconDesktop",
             @"FAIconLaptop",
             @"FAIconTablet",
             @"FAIconMobilePhone",
             @"FAIconCircleBlank",
             @"FAIconQuoteLeft",
             @"FAIconQuoteRight",
             @"FAIconSpinner",
             @"FAIconCircle",
             @"FAIconReply",
             @"FAIconFolderCloseAlt",
             @"FAIconFolderOpenAlt",
             @"FAIconExpandAlt",
             @"FAIconCollapseAlt",
             @"FAIconSmile",
             @"FAIconFrown",
             @"FAIconMeh",
             @"FAIconGamepad",
             @"FAIconKeyboard",
             @"FAIconFlagAlt",
             @"FAIconFlagCheckered",
             @"FAIconTerminal",
             @"FAIconCode",
             @"FAIconReplyAll",
             @"FAIconStarHalfAlt",
             @"FAIconLocationArrow",
             @"FAIconCrop",
             @"FAIconCodeFork",
             @"FAIconUnlink",
             @"FAIconQuestion",
             @"FAIconInfo",
             @"FAIconExclamation",
             @"FAIconSuperscript",
             @"FAIconSubscript",
             @"FAIconEraser",
             @"FAIconPuzzlePiece",
             @"FAIconMicrophone",
             @"FAIconMicrophoneOff",
             @"FAIconShield",
             @"FAIconCalendarEmpty",
             @"FAIconFireExtinguisher",
             @"FAIconRocket",
             @"FAIconMaxCDN",
             @"FAIconChevronSignLeft",
             @"FAIconChevronSignRight",
             @"FAIconChevronSignUp",
             @"FAIconChevronSignDown",
             @"FAIconHTML5",
             @"FAIconCSS3",
             @"FAIconFAIconAnchor",
             @"FAIconUnlockAlt",
             @"FAIconBullseye",
             @"FAIconEllipsisHorizontal",
             @"FAIconEllipsisVertical",
             @"FAIconRSS",
             @"FAIconPlaySign",
             @"FAIconTicket",
             @"FAIconMinusSignAlt",
             @"FAIconCheckMinus",
             @"FAIconLevelUp",
             @"FAIconLevelDown",
             @"FAIconCheckSign",
             @"FAIconEditSign",
             @"FAIconExternalLinkSign",
             @"FAIconShareSign"];
};

-(Class)cellClass{
    return [DemoBButtonVCCell class];
}
- (float)cellHeight:(NSIndexPath*)aIndexPath{
    return 45.0f;
}

@end
