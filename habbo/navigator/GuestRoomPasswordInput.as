package com.sulake.habbo.navigator
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1952;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.geom.Point;
   import package_42.class_1945;
   
   public class GuestRoomPasswordInput
   {
      
      private var _navigator:class_42;
      
      private var _window:class_2250;
      
      private var var_2171:class_1945;
      
      public function GuestRoomPasswordInput(param1:class_42)
      {
         super();
         _navigator = param1;
      }
      
      public function show(param1:class_1945, param2:Point = null) : void
      {
         var_2171 = param1;
         if(var_2171 == null)
         {
            return;
         }
         createWindow();
         if(_window == null)
         {
            return;
         }
         if(param2 != null)
         {
            param2.offset(-_window.width / 2,-_window.height / 2);
            _window.setGlobalPosition(param2);
         }
         _window.visible = true;
         _window.activate();
         var _loc3_:ITextWindow = _window.findChildByName("room_name") as ITextWindow;
         if(_loc3_ != null && param1 != null)
         {
            _loc3_.text = param1.roomName;
         }
         var _loc4_:class_1952 = _window.findChildByName("password_input") as class_1952;
         if(_loc4_ != null)
         {
            _loc4_.text = "";
         }
         setInfoText("${navigator.password.info}");
      }
      
      private function createWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         var _loc2_:XmlAsset = _navigator.assets.getAssetByName("password_input_xml") as XmlAsset;
         _window = _navigator.windowManager.buildFromXML(_loc2_.content as XML,2) as class_2250;
         if(_window == null)
         {
            return;
         }
         var _loc4_:class_1775 = _window.findChildByName("try") as class_1775;
         if(_loc4_ != null)
         {
            _loc4_.addEventListener("WME_CLICK",onTry);
         }
         var _loc3_:class_1741 = _window.findChildByName("cancel_region");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",close);
         }
         var _loc1_:class_1741 = _window.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",close);
         }
      }
      
      public function showRetry() : void
      {
         show(var_2171);
         setInfoText("${navigator.password.retryinfo}");
      }
      
      private function setInfoText(param1:String) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:ITextWindow = _window.findChildByName("info") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.caption = param1;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
         }
         _window = null;
         _navigator = null;
         var_2171 = null;
      }
      
      private function onTry(param1:WindowMouseEvent) : void
      {
         var _loc3_:class_1952 = _window.findChildByName("password_input") as class_1952;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:String = _loc3_.text;
         _navigator.goToRoom(var_2171.flatId,true,_loc2_);
         hide();
      }
      
      private function close(param1:WindowMouseEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         _window.dispose();
         _window = null;
      }
      
      private function hide(param1:WindowMouseEvent = null) : void
      {
         if(_window == null)
         {
            return;
         }
         _window.visible = false;
      }
   }
}

