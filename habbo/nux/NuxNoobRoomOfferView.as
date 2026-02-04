package com.sulake.habbo.nux
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class NuxNoobRoomOfferView
   {
      
      private var _frame:class_2250;
      
      private var var_59:HabboNuxDialogs;
      
      public function NuxNoobRoomOfferView(param1:HabboNuxDialogs)
      {
         super();
         var_59 = param1;
         show();
      }
      
      public function dispose() : void
      {
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
         var_59 = null;
      }
      
      private function hide() : void
      {
         if(var_59)
         {
            var_59.destroyNuxOfferView();
         }
      }
      
      private function show() : void
      {
         if(_frame != null)
         {
            return;
         }
         var _loc3_:XmlAsset = var_59.assets.getAssetByName("nux_noob_room_offer_xml") as XmlAsset;
         _frame = var_59.windowManager.buildFromXML(_loc3_.content as XML) as class_2250;
         if(_frame == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _frame.x = _frame.y = 20;
         var _loc1_:class_1741 = _frame.findChildByName("btnGo");
         if(_loc1_)
         {
            _loc1_.addEventListener("WME_CLICK",onGo);
         }
         var _loc2_:class_1741 = _frame.findChildByTag("close");
         if(_loc2_)
         {
            _loc2_.addEventListener("WME_CLICK",onClose);
         }
      }
      
      private function onGo(param1:WindowMouseEvent) : void
      {
         var_59.context.createLinkEvent("navigator/goto/predefined_noob_lobby");
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         var_59.destroyNoobRoomOfferView();
      }
   }
}

