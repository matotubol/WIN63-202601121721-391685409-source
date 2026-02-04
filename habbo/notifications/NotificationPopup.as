package com.sulake.habbo.notifications
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.utils.IModalDialog;
   
   public class NotificationPopup implements class_13
   {
      
      private var _notifications:HabboNotifications;
      
      private var var_393:IModalDialog;
      
      private var var_230:String;
      
      private var _parameters:class_55;
      
      public function NotificationPopup(param1:HabboNotifications, param2:String, param3:class_55)
      {
         super();
         _notifications = param1;
         var_230 = param2;
         _parameters = param3;
         var _loc10_:String = getNotificationPart("title",true);
         var _loc11_:String = getNotificationPart("message",true).replace(/\\r/g,"\r");
         var _loc6_:String = getNotificationPart("linkUrl",false);
         var _loc4_:String = null;
         var _loc5_:Boolean = _loc6_ != null && _loc6_.substr(0,6) == "event:";
         if(_loc6_ != null)
         {
            _loc4_ = getNotificationPart("linkTitle",false);
            if(_loc4_ == null)
            {
               _loc4_ = _loc6_;
            }
         }
         var _loc12_:IAsset = _notifications.assets.getAssetByName("layout_notification_popup_xml");
         var_393 = _notifications.windowManager.buildModalDialogFromXML(_loc12_.content as XML);
         var _loc9_:class_1812 = var_393.rootWindow as class_1812;
         _loc9_.procedure = windowProcedure;
         _loc9_.caption = _loc10_;
         if(_loc6_ != null)
         {
            if(_loc5_)
            {
               var _loc7_:class_1741 = _loc9_.findChildByName("action");
               _loc7_.visible = true;
               null.caption = _loc4_;
            }
            else
            {
               var _loc8_:class_1741 = _loc9_.findChildByName("link");
               _loc8_.visible = true;
               null.caption = _loc4_;
            }
         }
         _loc9_.findChildByName("message").caption = _loc11_;
         IStaticBitmapWrapperWindow(_loc9_.findChildByName("illustration")).assetUri = _notifications.getNotificationImageUrl(param3,param2);
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         var_393.dispose();
         var_393 = null;
         _notifications = null;
         var_230 = null;
         _parameters = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_393 == null;
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(disposed)
         {
            return;
         }
         switch(param1.type)
         {
            case "WME_CLICK":
               switch(param2.name)
               {
                  case "header_button_close":
                     dispose();
                     break;
                  case "action":
                     _notifications.createLinkEvent(getNotificationPart("linkUrl",false).substr(6));
                     dispose();
                     break;
                  case "link":
                     HabboWebTools.openWebPage(getNotificationPart("linkUrl",false),"habboMain");
               }
               break;
            case "WE_RESIZED":
               if(param2.name == "illustration")
               {
                  param2.parent.limits.minHeight = param2.height;
               }
         }
      }
      
      private function getNotificationPart(param1:String, param2:Boolean) : String
      {
         return _notifications.getNotificationPart(_parameters,var_230,param1,param2);
      }
   }
}

