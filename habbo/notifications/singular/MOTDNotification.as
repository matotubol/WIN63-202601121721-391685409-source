package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.window.class_38;
   
   public class MOTDNotification
   {
      
      private var _window:class_2250;
      
      private var var_167:class_27;
      
      private var var_2613:Array;
      
      private const LIST_ITEM_HEIGHT_MARGIN:int = 20;
      
      public function MOTDNotification(param1:Array, param2:class_40, param3:class_38)
      {
         super();
         if(!param3 || !param2)
         {
            return;
         }
         var_2613 = param1;
         var _loc6_:XmlAsset = param2.getAssetByName("motd_notification_xml") as XmlAsset;
         if(_loc6_ == null)
         {
            return;
         }
         _window = param3.buildFromXML(_loc6_.content as XML) as class_2250;
         if(_window == null)
         {
            return;
         }
         _window.procedure = eventHandler;
         _window.center();
         var _loc5_:XmlAsset = param2.getAssetByName("motd_notification_item_xml") as XmlAsset;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc4_:class_1812 = param3.buildFromXML(_loc5_.content as XML) as class_1812;
         var _loc10_:IItemListWindow = _window.findChildByName("message_list") as IItemListWindow;
         for each(var _loc9_ in var_2613)
         {
            var _loc8_:class_1812 = _loc4_.clone() as class_1812;
            var _loc7_:ITextWindow = _loc8_.findChildByName("message_text") as ITextWindow;
            _loc7_.text = null;
            null.height = null.textHeight + 20;
            _loc10_.addListItem(null);
         }
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         var_167 = null;
      }
      
      private function eventHandler(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "close":
            case "header_button_close":
               dispose();
               return;
            default:
               return;
         }
      }
   }
}

