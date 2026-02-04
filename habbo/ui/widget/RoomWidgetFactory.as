package com.sulake.habbo.ui.widget
{
   import com.sulake.core.assets.class_40;
   import com.sulake.habbo.ui.IRoomWidgetFactory;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.RoomUI;
   import com.sulake.habbo.ui.widget.avatarinfo.AvatarInfoWidget;
   import com.sulake.habbo.ui.widget.camera.CameraWidget;
   import com.sulake.habbo.ui.widget.camera.RoomThumbnailCameraWidget;
   import com.sulake.habbo.ui.widget.chatinput.RoomChatInputWidget;
   import com.sulake.habbo.ui.widget.chooser.UserChooserWidget;
   import com.sulake.habbo.ui.widget.chooser.newfurni.NewFurniChooserWidget;
   import com.sulake.habbo.ui.widget.chooser.newusers.NewUsersChooserWidget;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import com.sulake.habbo.ui.widget.doorbell.DoorbellWidget;
   import com.sulake.habbo.ui.widget.effects.EffectsWidget;
   import com.sulake.habbo.ui.widget.friendrequest.FriendRequestWidget;
   import com.sulake.habbo.ui.widget.furniture.CustomStackHeightWidget;
   import com.sulake.habbo.ui.widget.furniture.areahide.AreaHideFurniWidget;
   import com.sulake.habbo.ui.widget.furniture.backgroundcolor.BackgroundColorFurniWidget;
   import com.sulake.habbo.ui.widget.furniture.clothingchange.ClothingChangeFurnitureWidget;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
   import com.sulake.habbo.ui.widget.furniture.credit.CreditFurniWidget;
   import com.sulake.habbo.ui.widget.furniture.dimmer.DimmerFurniWidget;
   import com.sulake.habbo.ui.widget.furniture.ecotronbox.EcotronBoxFurniWidget;
   import com.sulake.habbo.ui.widget.furniture.externalimage.ExternalImageWidget;
   import com.sulake.habbo.ui.widget.furniture.friendfurni.FriendFurniConfirmWidget;
   import com.sulake.habbo.ui.widget.furniture.friendfurni.FriendFurniEngravingWidget;
   import com.sulake.habbo.ui.widget.furniture.highscore.HighScoreDisplayWidget;
   import com.sulake.habbo.ui.widget.furniture.mannequin.MannequinWidget;
   import com.sulake.habbo.ui.widget.furniture.petpackage.PetPackageFurniWidget;
   import com.sulake.habbo.ui.widget.furniture.placeholder.PlaceholderWidget;
   import com.sulake.habbo.ui.widget.furniture.present.PresentFurniWidget;
   import com.sulake.habbo.ui.widget.furniture.rentablespace.RentableSpaceDisplayWidget;
   import com.sulake.habbo.ui.widget.furniture.requirementsmissing.CustomUserNotificationWidget;
   import com.sulake.habbo.ui.widget.furniture.roomlink.FurnitureRoomLinkWidget;
   import com.sulake.habbo.ui.widget.furniture.stickie.SpamWallPostItFurniWidget;
   import com.sulake.habbo.ui.widget.furniture.stickie.StickieFurniWidget;
   import com.sulake.habbo.ui.widget.furniture.trophy.AchievementResolutionTrophyFurniWidget;
   import com.sulake.habbo.ui.widget.furniture.trophy.TrophyFurniWidget;
   import com.sulake.habbo.ui.widget.furniture.video.VimeoDisplayWidget;
   import com.sulake.habbo.ui.widget.furniture.video.YoutubeDisplayWidget;
   import com.sulake.habbo.ui.widget.infostand.InfoStandWidget;
   import com.sulake.habbo.ui.widget.loadingbar.LoadingBarWidget;
   import com.sulake.habbo.ui.widget.memenu.MeMenuWidget;
   import com.sulake.habbo.ui.widget.playlisteditor.PlayListEditorWidget;
   import com.sulake.habbo.ui.widget.poll.PollWidget;
   import com.sulake.habbo.ui.widget.roomchat.RoomChatWidget;
   import com.sulake.habbo.ui.widget.roomqueue.RoomQueueWidget;
   import com.sulake.habbo.ui.widget.roomtools.RoomToolsWidget;
   import com.sulake.habbo.ui.widget.uihelpbubbles.UiHelpBubblesWidget;
   import com.sulake.habbo.ui.widget.wordquiz.WordQuizWidget;
   import com.sulake.habbo.window.class_38;
   
   public class RoomWidgetFactory implements IRoomWidgetFactory
   {
      
      private var _roomUI:RoomUI;
      
      private var var_3906:int = 0;
      
      public function RoomWidgetFactory(param1:RoomUI)
      {
         super();
         _roomUI = param1;
      }
      
      public function dispose() : void
      {
         _roomUI = null;
      }
      
      public function createWidget(param1:String, param2:IRoomWidgetHandler) : IRoomWidget
      {
         if(_roomUI == null || _roomUI.windowManager == null)
         {
            return null;
         }
         var _loc3_:class_40 = _roomUI.assets;
         var _loc4_:class_38 = _roomUI.windowManager;
         switch(param1)
         {
            case "RWE_CHAT_WIDGET":
               return new RoomChatWidget(param2,_loc4_,_loc3_,_roomUI.localization,_roomUI,var_3906++,_roomUI);
            case "RWE_CHAT_INPUT_WIDGET":
               return new RoomChatInputWidget(param2,_loc4_,_loc3_,_roomUI.localization,_roomUI,_roomUI.desktop);
            case "RWE_INFOSTAND":
               return new InfoStandWidget(param2,_loc4_,_loc3_,_roomUI.localization,_roomUI,_roomUI.catalog);
            case "RWE_ME_MENU":
               return new MeMenuWidget(param2,_loc4_,_loc3_,_roomUI.localization,_roomUI);
            case "RWE_FURNI_PLACEHOLDER":
               return new PlaceholderWidget(param2,_loc4_,_loc3_,_roomUI.localization);
            case "RWE_FURNI_CREDIT_WIDGET":
               return new CreditFurniWidget(param2,_loc4_,_loc3_,_roomUI.localization);
            case "RWE_FURNI_STICKIE_WIDGET":
               return new StickieFurniWidget(param2,_loc4_,_loc3_);
            case "RWE_FURNI_PRESENT_WIDGET":
               return new PresentFurniWidget(param2,_loc4_,_loc3_,_roomUI.localization,_roomUI,_roomUI.catalog,_roomUI.inventory,_roomUI.roomEngine);
            case "RWE_FURNI_TROPHY_WIDGET":
               return new TrophyFurniWidget(param2,_loc4_,_loc3_,_roomUI.localization,_roomUI);
            case "RWE_FURNI_ACHIEVEMENT_RESOLUTION_ENGRAVING":
               return new AchievementResolutionTrophyFurniWidget(param2,_loc4_,_loc3_,_roomUI.localization,_roomUI);
            case "RWE_FURNI_ECOTRONBOX_WIDGET":
               return new EcotronBoxFurniWidget(param2,_loc4_,_loc3_);
            case "RWE_FURNI_PET_PACKAGE_WIDGET":
               return new PetPackageFurniWidget(param2,_loc4_,_loc3_,_roomUI.localization);
            case "RWE_DOORBELL":
               return new DoorbellWidget(param2,_loc4_,_loc3_,_roomUI.localization);
            case "RWE_LOADINGBAR":
               return new LoadingBarWidget(param2,_loc4_,_loc3_,_roomUI.localization,_roomUI);
            case "RWE_ROOM_QUEUE":
               return new RoomQueueWidget(param2,_loc4_,_loc3_,_roomUI.localization,_roomUI);
            case "RWE_ROOM_POLL":
               return new PollWidget(param2,_loc4_,_loc3_,_roomUI.localization);
            case "RWE_USER_CHOOSER":
               if(_roomUI.getBoolean("new_user_chooser.enabled"))
               {
                  return new NewUsersChooserWidget(param2,_loc4_,_loc3_,_roomUI.localization);
               }
               return new UserChooserWidget(param2,_loc4_,_loc3_,_roomUI.localization);
               break;
            case "RWE_FURNI_CHOOSER":
               return new NewFurniChooserWidget(param2,_loc4_,_loc3_,_roomUI.localization);
            case "RWE_ROOM_DIMMER":
               return new DimmerFurniWidget(param2,_loc4_,_loc3_,_roomUI.localization);
            case "RWE_FRIEND_REQUEST":
               return new FriendRequestWidget(param2,_loc4_,_loc3_,_roomUI.localization,_roomUI);
            case "RWE_CLOTHING_CHANGE":
               return new ClothingChangeFurnitureWidget(param2,_loc4_,_loc3_,_roomUI.localization);
            case "RWE_CONVERSION_TRACKING":
               return new RoomWidgetBase(param2,_loc4_);
            case "RWE_AVATAR_INFO":
               return new AvatarInfoWidget(param2,_loc4_,_loc3_,_roomUI,_roomUI.localization,_roomUI,_roomUI.catalog,_roomUI.userDefinedRoomEvents);
            case "RWE_PLAYLIST_EDITOR_WIDGET":
               return new PlayListEditorWidget(param2,_loc4_,_roomUI.soundManager,_loc3_,_roomUI.localization,_roomUI,_roomUI.catalog);
            case "RWE_SPAMWALL_POSTIT_WIDGET":
               return new SpamWallPostItFurniWidget(param2,_loc4_,_loc3_);
            case "RWE_EFFECTS":
               return new EffectsWidget(param2,_loc4_,_loc3_);
            case "RWE_MANNEQUIN":
               return new MannequinWidget(param2,_loc4_,_loc3_,_roomUI.localization);
            case "RWE_FURNITURE_CONTEXT_MENU":
               return new FurnitureContextMenuWidget(param2,_loc4_,_loc3_,_roomUI,_roomUI.localization,_roomUI,_roomUI.habboGroupsManager,_roomUI.catalog);
            case "RWE_CAMERA":
               return new CameraWidget(param2,_loc4_,_loc3_,_roomUI,_roomUI.localization,_roomUI);
            case "RWE_ROOM_BACKGROUND_COLOR":
               return new BackgroundColorFurniWidget(param2,_loc4_,_loc3_);
            case "RWE_AREA_HIDE":
               return new AreaHideFurniWidget(param2,_loc4_,_loc3_,_roomUI.localization,_roomUI.roomEngine);
            case "RWE_CUSTOM_USER_NOTIFICATION":
               return new CustomUserNotificationWidget(param2,_loc4_,_loc3_);
            case "RWE_FRIEND_FURNI_CONFIRM":
               return new FriendFurniConfirmWidget(param2,_loc4_,_loc3_,_roomUI.localization);
            case "RWE_FRIEND_FURNI_ENGRAVING":
               return new FriendFurniEngravingWidget(param2,_loc4_,_loc3_,_roomUI.localization);
            case "RWE_HIGH_SCORE_DISPLAY":
               return new HighScoreDisplayWidget(param2,_loc4_,_loc3_,_roomUI.localization);
            case "RWE_CUSTOM_STACK_HEIGHT":
               return new CustomStackHeightWidget(param2,_loc4_,_loc3_,_roomUI.localization);
            case "RWE_YOUTUBE":
               return new YoutubeDisplayWidget(param2,_loc4_,_loc3_,_roomUI.localization,_roomUI.habboTracking);
            case "RWE_RENTABLESPACE":
               return new RentableSpaceDisplayWidget(param2,_loc4_,_loc3_,_roomUI.localization);
            case "RWE_VIMEO":
               return new VimeoDisplayWidget(param2,_loc4_,_loc3_,_roomUI.localization);
            case "RWE_ROOM_TOOLS":
               return new RoomToolsWidget(param2,_loc4_,_loc3_,_roomUI);
            case "RWE_EXTERNAL_IMAGE":
               return new ExternalImageWidget(param2,_loc4_,_loc3_,_roomUI.localization,_roomUI.inventory,_roomUI.habboHelp,_roomUI.roomEngine,_roomUI);
            case "RWE_WORD_QUIZZ":
               return new WordQuizWidget(param2,_loc4_,_loc3_,_roomUI.localization);
            case "RWE_UI_HELP_BUBBLE":
               return new UiHelpBubblesWidget(param2,_loc4_,_loc3_,_roomUI.localization,_roomUI.friendBarView,_roomUI.toolbar,_roomUI.desktop,_roomUI);
            case "RWE_ROOM_THUMBNAIL_CAMERA":
               return new RoomThumbnailCameraWidget(param2,_loc4_,_loc3_,_roomUI,_roomUI.localization,_roomUI);
            case "RWE_ROOM_LINK":
               return new FurnitureRoomLinkWidget(param2,_loc4_);
            case "RWE_CRAFTING":
               return new CraftingWidget(param2,_loc4_,_roomUI);
            default:
               return null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _roomUI == null;
      }
   }
}

