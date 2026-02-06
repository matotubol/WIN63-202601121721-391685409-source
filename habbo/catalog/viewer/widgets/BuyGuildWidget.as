package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.communication.messages.outgoing.users.GetGuildCreationInfoMessageComposer;
   
   public class BuyGuildWidget extends CatalogWidget implements class_2612
   {
      
      private var _button:class_1775;
      
      public function BuyGuildWidget(param1:class_1812)
      {
         super(param1);
         if(_button)
         {
            _button.removeEventListener("WME_CLICK",onButtonClicked);
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         _button = window.findChildByName("start_guild_purchase") as class_1775;
         _button.addEventListener("WME_CLICK",onButtonClicked);
         return true;
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         if(HabboTracking.getInstance() != null)
         {
            HabboTracking.getInstance().trackGoogle("groupPurchase","catalogBuyClicked");
         }
         page.viewer.catalog.connection.send(new GetGuildCreationInfoMessageComposer());
         page.viewer.catalog.toggleCatalog("NORMAL");
      }
   }
}

