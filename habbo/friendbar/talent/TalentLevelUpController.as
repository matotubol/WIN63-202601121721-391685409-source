package com.sulake.habbo.friendbar.talent
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.window.widgets.class_3087;
   import com.sulake.habbo.communication.messages.incoming.talent.TalentLevelUpMessageEvent;
   import com.sulake.habbo.communication.messages.parser.talent.TalentLevelUpMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.talent.class_3878;
   import com.sulake.habbo.communication.messages.parser.talent.class_4056;
   import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
   
   public class TalentLevelUpController implements class_13
   {
      
      private var _habboTalent:HabboTalent;
      
      private var _disposed:Boolean;
      
      private var _window:class_1812;
      
      private var var_3759:String;
      
      private var var_1924:class_1741;
      
      private var var_1996:class_1741;
      
      private var var_1879:class_1741;
      
      public function TalentLevelUpController(param1:HabboTalent)
      {
         super();
         _habboTalent = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_1879 != null)
            {
               var_1879.dispose();
               var_1879 = null;
            }
            if(var_1924 != null)
            {
               var_1924.dispose();
               var_1924 = null;
            }
            if(var_1996 != null)
            {
               var_1996.dispose();
               var_1996 = null;
            }
            closeWindow();
            _habboTalent = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function initialize() : void
      {
         _habboTalent.communicationManager.addHabboConnectionMessageEvent(new TalentLevelUpMessageEvent(onTalentLevelUp));
      }
      
      private function onTalentLevelUp(param1:TalentLevelUpMessageEvent) : void
      {
         var _loc2_:TalentLevelUpMessageEventParser = param1.getParser();
         if(_loc2_.level == 1 && _loc2_.talentTrackName == "helper" && _habboTalent.citizenshipEnabled)
         {
            return;
         }
         showWindow(_loc2_.talentTrackName,_loc2_.level,_loc2_.rewardPerks,_loc2_.rewardProducts);
      }
      
      public function showWindow(param1:String, param2:int, param3:Vector.<class_4056>, param4:Vector.<class_3878>) : void
      {
         closeWindow();
         var_3759 = param1;
         _window = _habboTalent.getXmlWindow("level_up") as class_1812;
         _window.center();
         _window.procedure = onWindowEvent;
         IStaticBitmapWrapperWindow(_window.findChildByName("level_decoration")).assetUri = "${image.library.url}talent/" + param1 + "_levelup_" + param2 + ".png";
         _window.findChildByName("level_up_message").caption = "${talent.track." + param1 + ".levelup.message}";
         _window.findChildByName("level_title").caption = "${talent.track." + param1 + ".level." + param2 + ".title}";
         _window.findChildByName("level_description").caption = "${talent.track." + param1 + ".level." + param2 + ".description}";
         var _loc8_:IItemListWindow = IItemListWindow(_window.findChildByName("reward_list"));
         var _loc6_:class_1741 = _loc8_.removeListItem(_loc8_.getListItemByName("plus_template"));
         var_1924 = _loc8_.removeListItem(_loc8_.getListItemByName("reward_product_template"));
         var_1996 = _loc8_.removeListItem(_loc8_.getListItemByName("reward_vip_template"));
         var_1879 = _loc8_.removeListItem(_loc8_.getListItemByName("reward_perk_template"));
         var _loc7_:Boolean = false;
         for each(var _loc5_ in param3)
         {
            if(_loc7_)
            {
               _loc8_.addListItem(_loc6_.clone());
            }
            _loc8_.addListItem(createRewardPerk(_loc5_));
            _loc7_ = true;
         }
         for each(var _loc9_ in param4)
         {
            if(_loc7_)
            {
               _loc8_.addListItem(_loc6_.clone());
            }
            _loc8_.addListItem(createRewardProduct(_loc9_));
            _loc7_ = true;
         }
         if(_loc8_.numListItems < 1)
         {
            _window.findChildByName("level_rewards").visible = false;
            IItemListWindow(_window.findChildByName("level_up_layout")).arrangeListItems();
         }
      }
      
      private function createRewardPerk(param1:class_4056) : class_1741
      {
         var _loc2_:class_1812 = var_1879.clone() as class_1812;
         class_3087(class_2010(_loc2_.findChildByName("perk_image")).widget).badgeId = param1.perkId;
         _loc2_.findChildByName("perk_name").caption = "${perk." + param1.perkId + ".name}";
         return _loc2_;
      }
      
      private function createRewardProduct(param1:class_3878) : class_1741
      {
         var _loc2_:class_1741 = null;
         if(param1.vipDays == 0)
         {
            _loc2_ = var_1924.clone();
            IStaticBitmapWrapperWindow(_loc2_).assetUri = "${image.library.url}talent/reward_product_" + param1.productCode.toLowerCase().replace(" ","_") + ".png";
         }
         else
         {
            _loc2_ = var_1996.clone();
            class_1812(_loc2_).findChildByName("vip_length").caption = _habboTalent.localizationManager.getLocalizationWithParams("catalog.vip.item.header.days","","num_days",param1.vipDays);
         }
         return _loc2_;
      }
      
      private function closeWindow() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
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
            case "close_button":
               closeWindow();
               break;
            case "talent_button":
               closeWindow();
               _habboTalent.tracking.trackTalentTrackOpen(var_3759,"levelup");
               _habboTalent.send(new GetTalentTrackMessageComposer(var_3759));
         }
      }
   }
}

