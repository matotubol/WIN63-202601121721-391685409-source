package com.sulake.habbo.friendbar.talent
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.session.talent.TalentEnum;
   import com.sulake.habbo.utils.class_2724;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.habbo.window.widgets.class_2478;
   import com.sulake.habbo.window.widgets.class_3087;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.incoming.talent.TalentTrackMessageEvent;
   import com.sulake.habbo.communication.messages.parser.talent.class_3355;
   import com.sulake.habbo.communication.messages.parser.talent.TalentTrackMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.talent.class_3765;
   import com.sulake.habbo.communication.messages.parser.talent.class_3878;
   import com.sulake.habbo.communication.messages.parser.talent.class_3929;
   import com.sulake.habbo.communication.messages.parser.talent.class_4056;
   import com.sulake.habbo.communication.messages.incoming.users.class_1846;
   import com.sulake.habbo.communication.messages.incoming.users.EmailStatusResultEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ChangeEmailResultEvent;
   import com.sulake.habbo.communication.messages.outgoing.talent.GuideAdvertisementReadMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.ChangeEmailComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetEmailStatusComposer;
   
   public class TalentTrackController implements class_13
   {
      
      private static const MODAL_DIALOG_LAYER:int = 3;
      
      private static const HORIZONTAL_MARGIN:int = 100;
      
      private static const BEGIN_PANE_PREFIX:String = "begin_";
      
      private static const LEVEL_PANE_PREFIX:String = "level_pane_";
      
      private static const NO_CITIZENSHIP_SUFFIX:String = "_no_citizenship";
      
      private static const PROGRESS_BAR_MARGIN:int = 40;
      
      private static const DEFAULT_PADDING:int = 10;
      
      private static const REWARD_WIDTH:int = 200;
      
      private static const BADGE_RECT_SIZE:int = 60;
      
      private var _habboTalent:HabboTalent;
      
      private var _disposed:Boolean = false;
      
      private var var_393:IModalDialog;
      
      private var _window:class_1812;
      
      private var _taskProgressPopup:IModalDialog;
      
      private var var_233:IItemListWindow;
      
      private var _talentTrack:class_3929;
      
      private var _talentProgressMeter:TalentProgressMeter;
      
      private var var_941:class_1812;
      
      private var var_2124:class_1993;
      
      private var var_2096:class_1993;
      
      private var var_1924:class_1993;
      
      private var var_1996:class_1993;
      
      private var var_2108:class_1812;
      
      private var var_2140:class_1812;
      
      private var var_1805:class_1812;
      
      private var _overlayTemplate:class_1741;
      
      private var var_2970:int = -1;
      
      public function TalentTrackController(param1:HabboTalent)
      {
         super();
         _habboTalent = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_talentProgressMeter)
            {
               _talentProgressMeter.dispose();
               _talentProgressMeter = null;
            }
            destroyWindow();
            _habboTalent = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      public function get talentTrack() : class_3929
      {
         return _talentTrack;
      }
      
      public function initialize() : void
      {
         _habboTalent.communicationManager.addHabboConnectionMessageEvent(new TalentTrackMessageEvent(onTalentTrack));
         _habboTalent.communicationManager.addHabboConnectionMessageEvent(new ChangeEmailResultEvent(onChangeEmailResult));
         _habboTalent.communicationManager.addHabboConnectionMessageEvent(new HabboGroupDetailsMessageEvent(onGroupDetails));
         _habboTalent.communicationManager.addHabboConnectionMessageEvent(new EmailStatusResultEvent(onEmailStatus));
      }
      
      private function onEmailStatus(param1:EmailStatusResultEvent) : void
      {
         var _loc2_:class_1812 = getEmailContainer();
         if(_loc2_ != null)
         {
            getEmailText().text = param1.getParser().email;
            _loc2_.findChildByName("unverified_container").visible = !param1.getParser().isVerified;
            _loc2_.findChildByName("verified_txt").visible = param1.getParser().isVerified;
         }
      }
      
      private function onChangeEmailResult(param1:ChangeEmailResultEvent) : void
      {
         setEmailErrorStatus(true,param1.getParser().result);
      }
      
      private function onTalentTrack(param1:TalentTrackMessageEvent) : void
      {
         var _loc2_:TalentTrackMessageEventParser = param1.getParser();
         _talentTrack = _loc2_.getTalentTrack();
         createWindow();
      }
      
      private function onGroupDetails(param1:HabboGroupDetailsMessageEvent) : void
      {
         var _loc2_:class_1846 = param1.data;
         if(_loc2_.groupId == var_2970)
         {
            var_2970 = -1;
            _habboTalent.navigator.goToPrivateRoom(_loc2_.roomId);
         }
      }
      
      private function createWindow() : void
      {
         destroyWindow();
         var_393 = _habboTalent.getModalXmlWindow("talent_track");
         _window = class_1812(var_393.rootWindow);
         _window.procedure = onWindowEvent;
         var_393.background.procedure = onModalWindowBackgroundEvent;
         _habboTalent.windowManager.getWindowContext(3).getDesktopWindow().addEventListener("WE_RESIZED",onDesktopResized);
         var_233 = IItemListWindow(_window.findChildByName("panorama"));
         var_941 = class_1812(var_233.removeListItem(var_233.getListItemByName("level_pane")));
         var _loc2_:IItemListWindow = IItemListWindow(var_941.findChildByName("reward_list"));
         var_2124 = class_1993(_loc2_.removeListItem(_loc2_.getListItemByName("reward_achieved")));
         var_2096 = class_1993(_loc2_.removeListItem(_loc2_.getListItemByName("reward_locked")));
         var_1924 = class_1993(_loc2_.removeListItem(_loc2_.getListItemByName("reward_product")));
         var_1996 = class_1993(_loc2_.removeListItem(_loc2_.getListItemByName("reward_vip")));
         var _loc4_:IItemListWindow = IItemListWindow(var_941.findChildByName("task_list_top"));
         var_2108 = class_1812(_loc4_.removeListItem(_loc4_.getListItemByName("task_achieved")));
         var_2140 = class_1812(_loc4_.removeListItem(_loc4_.getListItemByName("task_ongoing")));
         var_1805 = class_1812(_loc4_.removeListItem(_loc4_.getListItemByName("task_locked")));
         _overlayTemplate = var_941.removeChild(var_941.findChildByName("action_overlay"));
         var _loc3_:Boolean = _habboTalent.citizenshipEnabled;
         for each(var _loc7_ in TalentEnum.asArray)
         {
            var _loc1_:class_1812 = var_233.getListItemByName("begin_" + _loc7_) as class_1812;
            if(_loc7_ != "citizenship")
            {
               _loc1_ = var_233.getListItemByName("begin_" + _loc7_ + "_no_citizenship") as class_1812;
            }
         }
         _window.findChildByName("frame_title").caption = "${talent.track." + _talentTrack.name + ".frame.title}";
         _window.findChildByName("frame_subtitle").caption = "${talent.track." + _talentTrack.name + ".frame.subtitle}";
         _window.findChildByName("progress_text").caption = "${talent.track." + _talentTrack.name + ".progress.title}";
         if(_loc3_ && _talentTrack.name != "citizenship")
         {
            _talentTrack.removeFirstLevel();
         }
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         while(0 < _talentTrack.levels.length)
         {
            createLevelPane(_talentTrack.levels[0],0);
            if(_talentTrack.levels[0].state == 1)
            {
               _loc6_ = 0;
            }
            _loc5_++;
         }
         _talentProgressMeter = new TalentProgressMeter(_habboTalent,this);
         var_233.setListItemIndex(var_233.getListItemByName("end_padding"),var_233.numListItems - 1);
         resizeWindow();
         scrollToLevel(_loc6_);
      }
      
      private function showAvatarInContainer(param1:class_1812) : void
      {
         var _loc2_:class_2010 = param1.findChildByName("avatar_image") as class_2010;
         if(_loc2_ != null)
         {
            class_2478(_loc2_.widget).figure = _habboTalent.sessionManager.figure;
         }
      }
      
      private function createLevelPane(param1:class_3355, param2:int) : void
      {
         var _loc16_:class_1993 = null;
         var _loc3_:ITextWindow = null;
         var _loc4_:ITextWindow = null;
         var _loc21_:ITextWindow = null;
         var _loc6_:ITextWindow = null;
         var _loc7_:IItemListWindow = null;
         var _loc18_:int = 0;
         var _loc22_:class_1741 = null;
         var _loc17_:* = undefined;
         var _loc15_:class_1741 = null;
         var _loc5_:Point = null;
         var _loc9_:class_1812 = class_1812(var_941.clone());
         var _loc14_:IItemListWindow = IItemListWindow(_loc9_.findChildByName("status_list"));
         var _loc19_:class_1812 = class_1812(_loc9_.findChildByName("level_reward"));
         var _loc10_:class_1812 = class_1812(_loc9_.findChildByName("level_task"));
         var _loc12_:IItemListWindow = IItemListWindow(_loc9_.findChildByName("task_list_top"));
         var _loc20_:IItemListWindow = IItemListWindow(_loc9_.findChildByName("task_list_bottom"));
         _loc9_.name = "level_pane_" + param2;
         _loc9_.findChildByName("level_title").caption = "${talent.track." + _talentTrack.name + ".level." + param1.level + ".title}";
         _loc9_.findChildByName("level_description").caption = "${talent.track." + _talentTrack.name + ".level." + param1.level + ".description}";
         if(param2 == 0)
         {
            _loc19_.width = 0;
            _loc19_.visible = false;
            _loc14_.x = 4 * 10;
         }
         else
         {
            _loc16_ = class_1993(_loc19_.findChildByName("border"));
            _loc3_ = ITextWindow(_loc19_.findChildByName("title_locked"));
            _loc4_ = ITextWindow(_loc19_.findChildByName("title_achieved"));
            _loc21_ = ITextWindow(_loc19_.findChildByName("description_locked"));
            _loc6_ = ITextWindow(_loc19_.findChildByName("description_achieved"));
            _loc7_ = IItemListWindow(_loc19_.findChildByName("reward_list"));
            switch(param1.state)
            {
               case 0:
                  _loc16_.color = 12434877;
                  _loc16_.findChildByName("unlocked").visible = false;
                  _loc3_.caption = "${talent.track." + _talentTrack.name + ".level." + param1.level + ".title}";
                  _loc4_.visible = false;
                  _loc21_.caption = "${talent.track." + _talentTrack.name + ".level." + param1.level + ".unlock}";
                  _loc6_.visible = false;
                  _loc19_.findChildByName("achieved").visible = false;
                  break;
               case 1:
               case 2:
                  _loc16_.color = 4537147;
                  _loc3_.visible = false;
                  _loc4_.caption = _habboTalent.localizationManager.getLocalization("talent.track.common.unlocked.level.prefix") + " " + _habboTalent.localizationManager.getLocalization("talent.track." + _talentTrack.name + ".level." + param1.level + ".title");
                  _loc21_.visible = false;
                  _loc6_.caption = "${talent.track." + _talentTrack.name + ".level." + param1.level + ".unlock}";
                  _loc19_.findChildByName("locked").visible = false;
            }
            if(param1.rewardCount == 0)
            {
               _loc18_ = Math.max(200,Math.max(_loc4_.width,_loc3_.width));
               _loc21_.width = _loc18_;
               _loc6_.width = _loc18_;
               _loc16_.width = _loc18_ + 2 * 10;
               _loc19_.width = _loc18_ + 2 * 10;
               _loc16_.height = _loc6_.y + Math.max(_loc6_.height,_loc21_.height) + 10;
               _loc19_.height = _loc16_.height + _loc16_.y;
               _loc7_.visible = false;
            }
            else if(param1.rewardCount == 1 && param1.rewardProducts.length > 0)
            {
               _loc18_ = Math.max(200 + 10 * 2,Math.max(_loc4_.width,_loc3_.width));
               _loc21_.width = _loc18_;
               _loc6_.width = _loc18_;
               _loc7_.addListItem(createRewardProduct(param1,param1.rewardProducts[0]));
               _loc16_.width = _loc18_ + 2 * 10;
               _loc19_.width = _loc18_ + 2 * 10;
            }
            else if(param1.rewardCount == 1)
            {
               _loc16_.width = 420;
               _loc21_.width = 200 * 2;
               _loc6_.width = 200 * 2;
               _loc7_.addListItem(param1.rewardPerks.length > 0 ? createRewardPerk(param1,param1.rewardPerks[0]) : createRewardProduct(param1,param1.rewardProducts[0]));
               _loc7_.arrangeListItems();
               _loc19_.width = _loc7_.width + 2 * 10;
               _loc16_.width = _loc7_.width + 2 * 10;
            }
            else
            {
               for each(var _loc11_ in param1.rewardPerks)
               {
                  _loc7_.addListItem(createRewardPerk(param1,_loc11_));
               }
               for each(var _loc8_ in param1.rewardProducts)
               {
                  _loc7_.addListItem(createRewardProduct(param1,_loc8_));
               }
               _loc7_.arrangeListItems();
               _loc19_.width = _loc7_.width + 2 * 10;
               _loc16_.width = _loc7_.width + 2 * 10;
               _loc6_.width = _loc16_.width - 2 * 10;
            }
         }
         if(param1.tasks.length == 0)
         {
            _loc10_.width = 0;
            _loc10_.visible = false;
         }
         else
         {
            _loc17_ = new Vector.<class_1741>();
            for each(var _loc13_ in param1.tasks)
            {
               _loc22_ = createTask(param1,_loc13_);
               if(_loc12_.numListItems == _loc20_.numListItems)
               {
                  _loc12_.addListItem(_loc22_);
               }
               else
               {
                  _loc20_.addListItem(_loc22_);
               }
               if(_loc13_.badgeCode == "ACH_SafetyQuizGraduate1" && _loc13_.state == 1)
               {
                  _loc17_.push(_loc22_);
               }
            }
            _loc12_.arrangeListItems();
            _loc20_.arrangeListItems();
            _loc10_.width = Math.max(_loc12_.width,_loc20_.width);
            for each(_loc22_ in _loc17_)
            {
               _loc15_ = _overlayTemplate.clone();
               _loc5_ = new Point();
               _loc9_.addChild(_loc15_);
               _loc22_.convertPointFromLocalToGlobalSpace(_loc5_);
               _loc9_.convertPointFromGlobalToLocalSpace(_loc5_);
               _loc15_.x += _loc5_.x;
               _loc15_.y += _loc5_.y;
               _loc15_.visible = true;
            }
         }
         _loc14_.arrangeListItems();
         _loc14_.width = _loc19_.width + 10 + _loc10_.width;
         _loc9_.width = _loc14_.x + _loc14_.width + 10;
         repositionLevelIllustration(param1,_loc9_);
         var_233.addListItem(_loc9_);
      }
      
      private function repositionLevelIllustration(param1:class_3355, param2:class_1812) : void
      {
         var _loc3_:class_1741 = param2.findChildByName("level_description");
         var _loc4_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(param2.findChildByName("level_illustration"));
         _loc4_.assetUri = "${image.library.url}talent/" + _talentTrack.name + "_" + param1.level + ".png";
         if(param1.level == 8 && _talentTrack.name == "helper")
         {
            _loc4_.width = 220;
            _loc4_.height = 270;
            _loc4_.x = Math.max(_loc3_.right,param2.width);
         }
         else if(param1.level == 0 && _talentTrack.name == "citizenship")
         {
            _loc4_.width = 0;
            _loc4_.x = Math.max(_loc3_.right,param2.width);
         }
         else if(param1.level == 4 && _talentTrack.name == "citizenship")
         {
            _loc4_.width = 220;
            _loc4_.height = 280;
            _loc4_.x = Math.max(_loc3_.right,param2.width);
         }
         else
         {
            _loc4_.x = Math.max(_loc3_.right,param2.width - _loc4_.width);
         }
         param2.width = Math.max(param2.width,_loc4_.right);
      }
      
      private function createRewardPerk(param1:class_3355, param2:class_4056) : class_1812
      {
         var _loc3_:class_1812 = null;
         switch(param1.state)
         {
            case 0:
               _loc3_ = class_1812(var_2096.clone());
               break;
            case 1:
            case 2:
               _loc3_ = class_1812(var_2124.clone());
               class_3087(class_2010(_loc3_.findChildByName("achieved")).widget).badgeId = param2.perkId;
         }
         var _loc5_:class_1741 = class_1741(_loc3_.findChildByName("title"));
         var _loc4_:class_1741 = ITextWindow(_loc3_.findChildByName("description"));
         _loc5_.caption = "${perk." + param2.perkId + ".name}";
         _loc4_.caption = "${perk." + param2.perkId + ".description}";
         if(param1.rewardCount == 1)
         {
            _loc3_.width = 200 * 2;
            _loc3_.findChildByName("title").width = 200 * 2 - 60;
            _loc3_.findChildByName("description").width = 200 * 2 - 60;
         }
         else
         {
            if(_loc4_.height > 30)
            {
               _loc4_.width += 4 * 10;
            }
            _loc4_.width = Math.max(_loc4_.width,_loc5_.width);
            _loc3_.width = Math.max(_loc4_.width,_loc5_.width) + 60 + 10;
         }
         return _loc3_;
      }
      
      private function createRewardProduct(param1:class_3355, param2:class_3878) : class_1812
      {
         var _loc3_:class_1812 = null;
         if(param2.vipDays == 0)
         {
            _loc3_ = class_1812(var_1924.clone());
            IStaticBitmapWrapperWindow(_loc3_.findChildByName("product_icon")).assetUri = "${image.library.url}talent/reward_product_" + param2.productCode.toLowerCase().replace(" ","_") + ".png";
         }
         else
         {
            _loc3_ = class_1812(var_1996.clone());
            _loc3_.findChildByName("vip_length").caption = _habboTalent.localizationManager.getLocalizationWithParams("catalog.vip.item.header.days","","num_days",param2.vipDays);
         }
         if(param1.state == 0)
         {
            _loc3_.color = 9934743;
            _loc3_.blend = 0.6;
         }
         return _loc3_;
      }
      
      private function createTask(param1:class_3355, param2:class_3765) : class_1812
      {
         var _loc6_:class_1812 = null;
         var _loc3_:IRegionWindow = null;
         if(param2.badgeCode == null || param2.badgeCode == "")
         {
            return null;
         }
         switch(param2.state)
         {
            case 0:
               _loc6_ = class_1812(var_1805.clone());
               break;
            case 1:
               _loc6_ = class_1812(var_2140.clone());
               class_3087(class_2010(_loc6_.findChildByName("badge")).widget).badgeId = param2.badgeCode;
               _loc6_.findChildByName("task_progress_fg").width = class_2724.map(param2.currentScore,0,param2.totalScore,0,48);
               _loc3_ = _loc6_.findChildByName("task_ongoing_region") as IRegionWindow;
               _loc3_.id = param2.achievementId;
               if(param2.badgeCode == "ACH_SafetyQuizGraduate1")
               {
                  _loc3_.toolTipCaption = "";
                  _loc3_.name = param2.badgeCode;
               }
               break;
            case 2:
               _loc6_ = class_1812(var_2108.clone());
               class_3087(class_2010(_loc6_.findChildByName("badge")).widget).badgeId = param2.badgeCode;
         }
         var _loc5_:class_1741 = _loc6_.findChildByName("title");
         var _loc4_:class_1741 = _loc6_.findChildByName("description");
         _loc5_.caption = _habboTalent.localizationManager.getAchievementName(param2.badgeCode).toUpperCase();
         _loc4_.caption = _habboTalent.localizationManager.getAchievementInstruction(param2.badgeCode);
         if(_loc5_.height > 20)
         {
            _loc5_.y -= 5;
            _loc4_.y += 5;
         }
         else if(_loc4_.height > 30)
         {
            _loc5_.y -= 5;
            _loc4_.y -= 5;
         }
         return _loc6_;
      }
      
      private function destroyWindow() : void
      {
         destroyTaskProgressDialog();
         if(_overlayTemplate != null)
         {
            _overlayTemplate.dispose();
            _overlayTemplate = null;
         }
         if(var_941)
         {
            var_941.dispose();
            var_941 = null;
         }
         if(var_2124)
         {
            var_2124.dispose();
            var_2124 = null;
         }
         if(var_2096)
         {
            var_2096.dispose();
            var_2096 = null;
         }
         if(var_1924)
         {
            var_1924.dispose();
            var_1924 = null;
         }
         if(var_1996)
         {
            var_1996.dispose();
            var_1996 = null;
         }
         if(var_2108)
         {
            var_2108.dispose();
            var_2108 = null;
         }
         if(var_2140)
         {
            var_2140.dispose();
            var_2140 = null;
         }
         if(var_1805)
         {
            var_1805.dispose();
            var_1805 = null;
         }
         if(var_393)
         {
            var_393.dispose();
            var_393 = null;
            _window = null;
            _habboTalent.windowManager.getWindowContext(3).getDesktopWindow().removeEventListener("WE_RESIZED",onDesktopResized);
         }
      }
      
      private function resizeWindow() : void
      {
         if(var_393 == null || Boolean(var_393.disposed))
         {
            return;
         }
         _window.x = 100;
         _window.width = _window.desktop.width - 2 * 100;
         _window.findChildByName("frame").width = _window.width;
         _window.findChildByName("panorama").width = _window.width;
         _window.findChildByName("panorama_scrollbar").width = _window.width;
         _talentProgressMeter.resize();
         var_233.arrangeListItems();
         _window.invalidate();
      }
      
      private function onDesktopResized(param1:class_1758) : void
      {
         resizeWindow();
      }
      
      private function onWindowEvent(param1:class_1758, param2:class_1741) : void
      {
         if(_window == null || Boolean(_window.disposed) || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
               destroyWindow();
               break;
            case "progress_container":
               var _loc3_:int = int(WindowMouseEvent(param1).localX);
               var_233.scrollH = 0;
               break;
            case "task_ongoing_region":
               createTaskProgressDialog(param2.id);
               break;
            case "citizenship_button":
               _habboTalent.tracking.trackTalentTrackOpen("citizenship","talentrack");
               _habboTalent.send(new GetTalentTrackMessageComposer("citizenship"));
               break;
            case "ACH_SafetyQuizGraduate1":
               closeAndLog(param2.name);
               _habboTalent.habboHelp.showSafetyBooklet();
               break;
            case "button_track_citizenship":
            case "button_track_helper":
         }
      }
      
      private function onModalWindowBackgroundEvent(param1:class_1758, param2:class_1741) : void
      {
         if(_window == null || Boolean(_window.disposed) || param1.type != "WME_CLICK")
         {
            return;
         }
         destroyWindow();
      }
      
      private function scrollToLevel(param1:int) : void
      {
         var _loc2_:class_1741 = null;
         if(param1 == 0)
         {
            var_233.scrollH = 0;
         }
         else
         {
            _loc2_ = var_233.getListItemByName("level_pane_" + param1);
            if(_loc2_ != null)
            {
               class_21.log(var_233.scrollH);
               var_233.scrollH = class_2724.map(_loc2_.x - 20,0,var_233.scrollableRegion.width - var_233.visibleRegion.width,0,1);
               class_21.log(_loc2_.x + " " + var_233.scrollableRegion.width + " " + class_2724.map(_loc2_.x,0,var_233.scrollableRegion.width,0,1) + " " + var_233.scrollH);
            }
         }
      }
      
      private function createTaskProgressDialog(param1:int) : void
      {
         destroyTaskProgressDialog();
         var _loc3_:class_3765 = _talentTrack.findTaskByAchievementId(param1);
         if(_loc3_ == null || _loc3_.badgeCode == null || _loc3_.badgeCode == "")
         {
            return;
         }
         _habboTalent.tracking.trackEventLog("Talent",talentTrack.name,"talent.progress.show",_loc3_.badgeCode);
         if(_loc3_.badgeCode == "ACH_GuideAdvertisementReader1")
         {
            setupTourAdvertisement();
            return;
         }
         _taskProgressPopup = _habboTalent.getModalXmlWindow("task_progress_dialog");
         _taskProgressPopup.rootWindow.procedure = onTaskProgressWindowEvent;
         _taskProgressPopup.background.procedure = onTaskProgressBackgroundWindowEvent;
         var _loc2_:class_1812 = class_1812(_taskProgressPopup.rootWindow);
         _loc2_.findChildByName("instruction").caption = _habboTalent.localizationManager.getAchievementInstruction(_loc3_.badgeCode);
         _loc2_.findChildByName("title").caption = _habboTalent.localizationManager.getAchievementName(_loc3_.badgeCode);
         _loc2_.findChildByName("progress_text").caption = _habboTalent.localizationManager.getLocalization("talent.track.task.progress.dialog.progress") + " " + _loc3_.currentScore + "/" + _loc3_.totalScore;
         class_3087(class_2010(_loc2_.findChildByName("badge")).widget).badgeId = _loc3_.badgeCode;
         getEmailContainer().visible = false;
         if(_habboTalent.citizenshipEnabled)
         {
            var _loc7_:String = _habboTalent.localizationManager.getLocalization("talent.track.task.action." + _talentTrack.name + "." + mapBadgeCode(_loc3_.badgeCode) + ".description","");
            var _loc5_:String = _habboTalent.localizationManager.getLocalization("talent.track.task.action." + _talentTrack.name + "." + mapBadgeCode(_loc3_.badgeCode) + ".link","");
            var _loc4_:Boolean = null != "";
            _loc2_.findChildByName("action_separator").visible = false;
            _loc2_.findChildByName("action_title").visible = false;
            setText(_loc2_,"action_description",null);
            setText(_loc2_,"action_link",null);
            _loc2_.findChildByName("action_link").name = _loc3_.badgeCode;
            _loc2_.findChildByName("progress_separator").visible = null != "";
            if(_loc3_.badgeCode == "ACH_EmailVerification1" && emailChangeEnabled)
            {
               getEmailContainer().visible = true;
               getEmailContainer().findChildByName("change_email_region").procedure = onChangeEmail;
               getEmailText().procedure = onEmailTxt;
               _habboTalent.send(new GetEmailStatusComposer());
               setEmailErrorStatus(false);
            }
         }
         else
         {
            _loc2_.findChildByName("action_separator").visible = false;
            _loc2_.findChildByName("action_title").visible = false;
            _loc2_.findChildByName("action_description").visible = false;
            _loc2_.findChildByName("action_link").visible = false;
         }
         IItemListWindow(_loc2_.findChildByName("top_list")).arrangeListItems();
         if(_loc3_.currentScore <= 0)
         {
            _loc2_.findChildByName("achieved_left").visible = false;
            _loc2_.findChildByName("achieved_right").visible = false;
            _loc2_.findChildByName("achieved_mid").visible = false;
         }
         else if(_loc3_.currentScore < _loc3_.totalScore)
         {
            _loc2_.findChildByName("achieved_right").visible = false;
            _loc2_.findChildByName("achieved_mid").width = class_2724.map(_loc3_.currentScore,0,_loc3_.totalScore,0,_loc2_.findChildByName("unachieved_mid").width);
         }
         var _loc6_:IItemListWindow = IItemListWindow(_loc2_.findChildByName("list"));
         if(!_loc3_.hasProgressDisplay())
         {
            _loc6_.removeListItem(_loc6_.getListItemByName("progress_main_container"));
         }
         _loc6_.arrangeListItems();
      }
      
      private function getEmailContainer() : class_1812
      {
         if(_taskProgressPopup == null || _taskProgressPopup.rootWindow == null)
         {
            return null;
         }
         var _loc1_:class_1812 = class_1812(_taskProgressPopup.rootWindow);
         return _loc1_ == null ? null : class_1812(_loc1_.findChildByName("email_container"));
      }
      
      private function mapBadgeCode(param1:String) : String
      {
         if(param1 == "ACH_RoomEntry1" || param1 == "ACH_RoomEntry2")
         {
            return "ACH_RoomEntry";
         }
         return param1;
      }
      
      private function setText(param1:class_1812, param2:String, param3:String) : void
      {
         var _loc4_:class_1741 = param1.findChildByName(param2);
         _loc4_.caption = param3;
         _loc4_.visible = param3 != "";
      }
      
      private function destroyTaskProgressDialog() : void
      {
         if(_taskProgressPopup != null)
         {
            _taskProgressPopup.dispose();
            _taskProgressPopup = null;
         }
      }
      
      private function onTaskProgressWindowEvent(param1:class_1758, param2:class_1741) : void
      {
         if(_taskProgressPopup == null || Boolean(_taskProgressPopup.disposed) || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
            case "thanks_button":
               destroyTaskProgressDialog();
               break;
            case "ACH_HabboWayGraduate1":
               closeAndLog(param2.name);
               _habboTalent.habboHelp.showHabboWay();
               break;
            case "ACH_GuideGroupMember1":
               closeAndLog(param2.name);
               var _loc3_:int = _habboTalent.getInteger("guide.help.alpha.groupid",0);
               break;
            case "ACH_SafetyQuizGraduate1":
               closeAndLog(param2.name);
               _habboTalent.habboHelp.showSafetyBooklet();
               break;
            case "ACH_RoomEntry1":
            case "ACH_RoomEntry2":
               closeAndLog(param2.name);
               _habboTalent.navigator.openNavigator(null);
               break;
            case "ACH_AvatarLooks1":
               closeAndLog(param2.name);
               _habboTalent.avatarEditor.openEditor(0,null,null,true);
               _habboTalent.avatarEditor.loadOwnAvatarInEditor(0);
         }
      }
      
      private function closeAndLog(param1:String) : void
      {
         destroyWindow();
         _habboTalent.tracking.trackEventLog("Talent",_talentTrack.name,"talent.progress.click_activity",param1);
      }
      
      private function setupTourAdvertisement() : void
      {
         _taskProgressPopup = _habboTalent.getModalXmlWindow("tour_task_progress_dialog");
         var _loc1_:class_1812 = class_1812(_taskProgressPopup.rootWindow);
         _loc1_.findChildByName("take_tour_button").procedure = onTakeTour;
         _loc1_.findChildByName("decline_tour_region").procedure = onDeclineTour;
         _loc1_.findChildByName("header_button_close").procedure = onCloseTourAd;
      }
      
      private function onTakeTour(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            destroyWindow();
            destroyTaskProgressDialog();
            _habboTalent.send(new GuideAdvertisementReadMessageComposer());
            _habboTalent.habboHelp.requestGuide();
            _habboTalent.tracking.trackEventLog("Help","","tour.new_user.accept");
            _habboTalent.tracking.trackGoogle("newbieTourWindow","click_acceptTour");
         }
      }
      
      private function onCloseTourAd(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            destroyTaskProgressDialog();
         }
      }
      
      private function onDeclineTour(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            destroyWindow();
            destroyTaskProgressDialog();
            _habboTalent.send(new GuideAdvertisementReadMessageComposer());
            _habboTalent.tracking.trackEventLog("Help","","tour.new_user.cancel");
            _habboTalent.tracking.trackGoogle("newbieTourWindow","click_refuseTour");
         }
      }
      
      private function onChangeEmail(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:String = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = getEmailText().text;
            _habboTalent.send(new ChangeEmailComposer(_loc3_));
         }
      }
      
      private function onEmailTxt(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WE_FOCUSED")
         {
            setEmailErrorStatus(false);
         }
      }
      
      private function setEmailErrorStatus(param1:Boolean, param2:int = 0) : void
      {
         if(getEmailContainer() == null)
         {
            return;
         }
         var _loc3_:Boolean = param1 && param2 != 0;
         var _loc4_:class_1812 = getEmailContainer();
         var _loc5_:class_1741 = _loc4_.findChildByName("error_txt");
         _loc5_.visible = _loc3_;
         _loc5_.caption = "${welcome.gift.email.error." + param2 + "}";
         _loc4_.findChildByName("error_border").visible = _loc3_;
         _loc4_.findChildByName("change_email_region").visible = !param1;
         _loc4_.findChildByName("changed_container").visible = param1 && param2 == 0;
      }
      
      private function getEmailText() : ITextFieldWindow
      {
         return ITextFieldWindow(getEmailContainer().findChildByName("email_txt"));
      }
      
      private function onTaskProgressBackgroundWindowEvent(param1:class_1758, param2:class_1741) : void
      {
         if(_taskProgressPopup == null || Boolean(_taskProgressPopup.disposed) || param1.type != "WME_CLICK")
         {
            return;
         }
         destroyTaskProgressDialog();
      }
      
      private function get emailChangeEnabled() : Boolean
      {
         return _habboTalent.getBoolean("talent.progress.emailchange.enabled");
      }
   }
}

