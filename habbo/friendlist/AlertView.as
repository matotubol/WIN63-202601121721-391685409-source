package com.sulake.habbo.friendlist
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class AlertView implements class_13
   {
      
      private static var var_1518:Dictionary = new Dictionary();
      
      private var _friendList:HabboFriendList;
      
      private var var_726:class_2250;
      
      private var _xmlFileName:String;
      
      private var var_839:String;
      
      private var _disposed:Boolean;
      
      public function AlertView(param1:HabboFriendList, param2:String, param3:String = null)
      {
         super();
         _friendList = param1;
         _xmlFileName = param2;
         var_839 = param3;
      }
      
      public function show() : void
      {
         var _loc1_:class_2250 = class_2250(var_1518[_xmlFileName]);
         if(_loc1_ != null)
         {
            _loc1_.dispose();
         }
         var_726 = getAlert();
         if(var_839 != null)
         {
            var_726.caption = var_839;
         }
         setupContent(var_726.content);
         var _loc2_:Rectangle = Util.getLocationRelativeTo(_friendList.view.mainWindow,var_726.width,var_726.height);
         var_726.x = _loc2_.x;
         var_726.y = _loc2_.y;
         var_1518[_xmlFileName] = var_726;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_726 != null)
         {
            var_726.destroy();
            var_726 = null;
         }
         _friendList = null;
      }
      
      internal function setupContent(param1:class_1812) : void
      {
      }
      
      internal function onClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      private function getAlert() : class_2250
      {
         var _loc1_:class_2250 = class_2250(_friendList.getXmlWindow(this._xmlFileName));
         var _loc2_:class_1741 = _loc1_.findChildByTag("close");
         _loc2_.procedure = onClose;
         return _loc1_;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get friendList() : HabboFriendList
      {
         return _friendList;
      }
   }
}

