package com.sulake.habbo.toolbar.extensions
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.localization.class_26;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.quest.class_3170;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.toolbar.IExtensionView;
   import com.sulake.habbo.window.class_38;
   import flash.events.IEventDispatcher;
   import package_64.class_2477;
   
   public class CitizenshipVipQuestsPromoExtension
   {
      
      private var _windowManager:class_38;
      
      private var _assets:class_40;
      
      private var name_1:IEventDispatcher;
      
      private var _localization:class_26;
      
      private var var_37:IConnection;
      
      private var var_430:IExtensionView;
      
      private var var_18:class_1993;
      
      private var _disposed:Boolean = false;
      
      private var _expanded:Boolean = true;
      
      private var var_4284:int = 216;
      
      private var _vipQuestsCampaignName:String;
      
      private var var_2129:IMessageEvent = null;
      
      public function CitizenshipVipQuestsPromoExtension(param1:HabboToolbar, param2:class_38, param3:class_40, param4:IEventDispatcher, param5:class_26, param6:IConnection)
      {
         super();
         _windowManager = param2;
         _assets = param3;
         name_1 = param4;
         _localization = param5;
         var_37 = param6;
         var_430 = param1.extensionView;
         var_2129 = new class_2477(onCitizenshipQuestPromoEnabled);
         var_37.addMessageEvent(var_2129);
         _vipQuestsCampaignName = param1.getProperty("citizenship.vip.tutorial.quest.campaign.name");
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(var_37 && var_2129)
         {
            var_37.removeMessageEvent(var_2129);
            var_2129 = null;
         }
         destroyWindow();
         _localization = null;
         _assets = null;
         name_1 = null;
         _windowManager = null;
         var_37 = null;
         var_430 = null;
         _disposed = true;
      }
      
      private function createWindow() : class_1993
      {
         var _loc2_:IAsset = _assets.getAssetByName("vip_quests_promo_xml");
         if(_loc2_)
         {
            var _loc1_:class_1993 = _windowManager.buildFromXML(_loc2_.content as XML,1) as class_1993;
         }
         return null;
      }
      
      private function destroyWindow() : void
      {
         if(var_430)
         {
            var_430.detachExtension("vip_quests");
         }
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         if(var_37)
         {
            var_37.send(new class_3170(_vipQuestsCampaignName));
         }
         destroyWindow();
      }
      
      private function onMinMax(param1:WindowMouseEvent) : void
      {
         _expanded = !_expanded;
         assignState();
      }
      
      private function assignState() : void
      {
         IItemListWindow(var_18.findChildByName("content_itemlist")).visible = _expanded;
         IStaticBitmapWrapperWindow(var_18.findChildByName("promo_img")).visible = _expanded;
         var_18.height = _expanded ? var_4284 : 33;
      }
      
      private function onCitizenshipQuestPromoEnabled(param1:IMessageEvent) : void
      {
         if(var_18 == null)
         {
            var_18 = createWindow();
         }
         assignState();
         var_430.detachExtension("club_promo");
         var_430.attachExtension("vip_quests",var_18,10);
      }
   }
}

