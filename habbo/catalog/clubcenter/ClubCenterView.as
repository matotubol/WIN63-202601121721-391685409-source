package com.sulake.habbo.catalog.clubcenter
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.catalog.purse.class_1831;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.widgets.IRoomPreviewerWidget;
   import flash.display.BitmapData;
   import package_3.class_3429;
   
   public class ClubCenterView implements class_259
   {
      
      private var var_55:HabboClubCenter;
      
      private var _window:class_1812;
      
      private var var_16:IRoomPreviewerWidget;
      
      private var var_975:String;
      
      public function ClubCenterView(param1:HabboClubCenter, param2:class_38, param3:String)
      {
         super();
         var_55 = param1;
         _window = param2.buildFromXML(XML(var_55.assets.getAssetByName("club_center_xml").content)) as class_1812;
         if(!container)
         {
            return;
         }
         if(!var_55.isKickbackEnabled())
         {
            removeElement("special_breakdown_link");
            removeElement("special_content");
            removeElement("special_content_postit");
            container.invalidate();
         }
         else
         {
            setElementVisibility("special_amount_icon",false);
            setElementVisibility("special_amount_title",false);
            setElementVisibility("special_amount_content",false);
            setElementVisibility("special_breakdown_link",false);
            setElementVisibility("special_time_content",false);
         }
         setElementVisibility("btn_earn",false);
         var_55.getOffers();
         _window.center();
         _window.addEventListener("WE_RELOCATE",onRelocate);
         var_975 = param3;
         var_16 = class_2010(_window.findChildByName("avatar")).widget as IRoomPreviewerWidget;
         var _loc4_:class_1827 = var_55.avatarRenderManager.createAvatarImage(param3,"h",null,this);
         if(_loc4_)
         {
            _loc4_.setDirection("full",4);
            var_16.showPreview(_loc4_.getCroppedImage("full"));
         }
         container.procedure = onInput;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener("WE_RELOCATE",onRelocate);
            _window.dispose();
            _window = null;
         }
         var_55 = null;
      }
      
      public function dataReceived(param1:class_3429, param2:class_1831, param3:int, param4:BitmapData) : void
      {
         var _loc7_:int = 0;
         var _loc6_:class_1775 = null;
         var _loc9_:String = var_55.resolveClubStatus();
         setElementText("status_title","${hccenter.status." + _loc9_ + "}");
         if(!param1 || !param2)
         {
            setElementVisibility("gift_content",false);
            setElementVisibility("special_container",false);
            return;
         }
         setElementVisibility("gift_content",true);
         var _loc5_:String = getLocalization("hccenter.status." + _loc9_ + ".info");
         _loc5_ = _loc5_.replace("%timeleft%",formatMinutes(param2.minutesUntilExpiration));
         _loc5_ = _loc5_.replace("%joindate%",param1.firstSubscriptionDate);
         _loc5_ = _loc5_.replace("%streakduration%",formatDays(param1.currentHcStreak));
         setElementText("status_info",_loc5_);
         var _loc8_:class_2251 = container.findChildByName("hc_badge") as class_2251;
         if(_loc8_ && param4)
         {
            _loc8_.bitmap = param4;
         }
         if(var_55.isKickbackEnabled())
         {
            if(param1.timeUntilPayday < 60)
            {
               setElementText("special_time_content",getLocalization("hccenter.special.time.soon"));
            }
            else
            {
               setElementText("special_time_content",formatMinutes(param1.timeUntilPayday));
            }
            setElementVisibility("special_time_content",true);
            _loc7_ = param1.creditRewardForMonthlySpent + param1.creditRewardForStreakBonus;
            if(_loc7_ > 0)
            {
               setElementVisibility("special_amount_icon",true);
               setElementVisibility("special_amount_title",true);
               setElementVisibility("special_amount_content",true);
               setElementVisibility("special_breakdown_link",true);
               setElementText("special_amount_content",getLocalization("hccenter.special.sum").replace("%credits%",_loc7_));
            }
         }
         _loc6_ = container.findChildByName("btn_gift") as class_1775;
         if(_loc9_ == "active" && param3 > 0)
         {
            if(_loc6_)
            {
               _loc6_.caption = "${hccenter.btn.gifts.redeem}";
            }
            setElementText("gift_info",getLocalization("hccenter.unclaimedgifts").replace("%unclaimedgifts%",param3));
         }
         else
         {
            if(_loc6_)
            {
               _loc6_.caption = "${hccenter.btn.gifts.view}";
            }
            setElementText("gift_info",getLocalization("hccenter.gift.info"));
         }
         _loc6_ = container.findChildByName("btn_buy") as class_1775;
         if(_loc9_ == "active")
         {
            if(_loc6_)
            {
               _loc6_.caption = "${hccenter.btn.extend}";
            }
         }
         else if(_loc6_)
         {
            _loc6_.caption = "${hccenter.btn.buy}";
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc2_:class_1827 = null;
         if(param1 == var_975)
         {
            _loc2_ = var_55.avatarRenderManager.createAvatarImage(var_975,"h",null,this);
            _loc2_.setDirection("full",4);
            var_16.showPreview(_loc2_.getCroppedImage("full"));
         }
      }
      
      private function onInput(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_DOWN" || !var_55)
         {
            return;
         }
         param1.stopImmediatePropagation();
         param1.stopPropagation();
         switch(param2.name)
         {
            case "header_button_close":
               var_55.removeView();
               return;
            case "special_infolink":
               var_55.openPaydayHelpPage();
               break;
            case "special_breakdown_link":
               var_55.showPaydayBreakdownView();
               break;
            case "general_infolink":
               var_55.openHelpPage();
               break;
            case "btn_gift":
               var_55.openClubGiftPage();
               var_55.removeView();
               break;
            case "btn_buy":
               var_55.openPurchasePage();
               var_55.removeView();
               break;
            case "btn_earn":
               if(var_55.offerCenter)
               {
                  var_55.offerCenter.showVideo();
               }
               break;
            default:
               return;
         }
      }
      
      private function onRelocate(param1:class_1758) : void
      {
         var_55.removeBreakdown();
      }
      
      private function get container() : class_1812
      {
         return _window;
      }
      
      private function setElementText(param1:String, param2:String) : void
      {
         if(!container)
         {
            return;
         }
         var _loc3_:ITextWindow = container.findChildByName(param1) as ITextWindow;
         if(_loc3_)
         {
            _loc3_.text = param2;
         }
      }
      
      private function setElementVisibility(param1:String, param2:Boolean) : void
      {
         if(!container)
         {
            return;
         }
         var _loc3_:class_1741 = container.findChildByName(param1);
         if(_loc3_)
         {
            _loc3_.visible = param2;
         }
      }
      
      public function getSpecialCalloutAnchor() : class_1741
      {
         return container ? container.findChildByName("special_content_postit") : null;
      }
      
      private function removeElement(param1:*) : void
      {
         if(!container)
         {
            return;
         }
         var _loc3_:class_1741 = container.findChildByName(param1);
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:class_1812 = _loc3_.parent as class_1812;
         _loc2_.removeChild(_loc3_);
      }
      
      private function getLocalization(param1:String) : String
      {
         if(!var_55 || !var_55.localization)
         {
            return "";
         }
         return var_55.localization.getLocalization(param1,param1);
      }
      
      public function formatMinutes(param1:int) : String
      {
         return FriendlyTime.getShortFriendlyTime(var_55.localization,param1 * 60);
      }
      
      public function formatDays(param1:int) : String
      {
         return FriendlyTime.getShortFriendlyTime(var_55.localization,param1 * 86400);
      }
      
      public function get disposed() : Boolean
      {
         return var_55 == null;
      }
      
      public function setVideoOfferButtonVisibility(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:class_1741 = _window.findChildByName("btn_earn");
         if(_loc3_)
         {
            _loc3_.visible = param1;
            if(param2)
            {
               _loc3_.enable();
               _loc3_.alpha = 0;
            }
            else
            {
               _loc3_.disable();
               _loc3_.alpha = 51;
            }
         }
      }
   }
}

