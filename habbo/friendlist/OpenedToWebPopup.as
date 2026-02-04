package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.class_1812;
   import flash.events.Event;
   import flash.utils.Timer;
   
   public class OpenedToWebPopup
   {
      
      private var _friendList:HabboFriendList;
      
      private var var_726:class_1812;
      
      private var var_323:Timer;
      
      public function OpenedToWebPopup(param1:HabboFriendList)
      {
         super();
         _friendList = param1;
      }
      
      public function show(param1:int, param2:int) : void
      {
         if(var_726 != null)
         {
            close(null);
         }
         var_726 = getOpenedToWebAlert();
         if(var_323 != null)
         {
            var_323.stop();
         }
         var_323 = new Timer(2000,1);
         var_323.addEventListener("timer",close);
         var_323.start();
         var_726.x = param1;
         var_726.y = param2;
      }
      
      private function close(param1:Event) : void
      {
         var_726.destroy();
         var_726 = null;
      }
      
      private function getOpenedToWebAlert() : class_1812
      {
         var _loc1_:class_1812 = class_1812(_friendList.getXmlWindow("opened_to_web_popup"));
         _friendList.refreshButton(_loc1_,"opened_to_web",true,null,0);
         return _loc1_;
      }
   }
}

