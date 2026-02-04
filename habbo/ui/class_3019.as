package com.sulake.habbo.ui
{
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1970;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.window.class_38;
   import flash.geom.Rectangle;
   
   public class class_3019
   {
      
      private static const ROOM_VIEW:String = "room_view";
      
      private static const ROOM_NEW_CHAT:String = "room_new_chat";
      
      private static const ROOM_WIDGET:String = "room_widget";
      
      private static const BOTTOM_MARGIN:int = 47;
      
      private var _layoutContainer:class_1812;
      
      public function class_3019()
      {
         super();
      }
      
      public function dispose() : void
      {
         if(_layoutContainer != null)
         {
            _layoutContainer.dispose();
         }
      }
      
      public function setLayout(param1:XML, param2:class_38, param3:class_16) : void
      {
         if(param1 == null || param2 == null)
         {
            throw new Error("Unable to set room desktop layout.");
         }
         _layoutContainer = param2.buildFromXML(param1,0) as class_1812;
         if(_layoutContainer == null)
         {
            throw new Error("Failed to build layout from XML.");
         }
         _layoutContainer.width = _layoutContainer.desktop.width;
         _layoutContainer.height = _layoutContainer.desktop.height;
         var _loc4_:class_1812 = _layoutContainer.desktop as class_1812;
         _loc4_.addChild(_layoutContainer);
         _layoutContainer.findChildByTag("room_widget_infostand").y = _layoutContainer.findChildByTag("room_widget_infostand").y - 47;
         var _loc6_:int = 0;
         while(0 < _layoutContainer.numChildren)
         {
            var _loc7_:class_1741 = _layoutContainer.getChildAt(0);
            var _loc5_:int = 1048576;
            if(null.testParamFlag(0))
            {
               null.addEventListener("WE_CHILD_RESIZED",trimContainer);
            }
            _loc6_++;
         }
      }
      
      private function trimContainer(param1:class_1758) : void
      {
         var _loc2_:class_1812 = param1.window as class_1812;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.numChildren != 1)
         {
            return;
         }
         var _loc3_:class_1741 = _loc2_.getChildAt(0);
         if(_loc3_ == null)
         {
            return;
         }
         _loc2_.width = _loc3_.width;
         _loc2_.height = _loc3_.height;
      }
      
      private function getWidgetContainer(param1:String, param2:class_1741) : class_1812
      {
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         if(param2 == null)
         {
            return null;
         }
         if(param1 == "RWE_HIGH_SCORE_DISPLAY" || param1 == "RWE_WORD_QUIZZ")
         {
            return _layoutContainer.getChildByName("background_widgets") as class_1812;
         }
         if(param1 == "RWE_CHAT_INPUT_WIDGET")
         {
            return param2.desktop as class_1812;
         }
         var _loc8_:Array = param2.tags;
         _loc6_ = 0;
         while(_loc6_ < _loc8_.length)
         {
            if(String(_loc8_[_loc6_]).indexOf("room_widget") == 0)
            {
               var _loc5_:String = _loc8_[_loc6_] as String;
               break;
            }
            _loc6_++;
         }
         return null;
      }
      
      public function addWidgetWindow(param1:String, param2:class_1741) : Boolean
      {
         if(param2 == null)
         {
            return false;
         }
         var _loc3_:class_1812 = getWidgetContainer(param1,param2);
         if(_loc3_ == null)
         {
            return false;
         }
         if(param1 == "RWE_CHAT_INPUT_WIDGET")
         {
            _loc3_.addChild(param2);
            return true;
         }
         param2.x = 0;
         param2.y = 0;
         _loc3_.addChild(param2);
         _loc3_.width = param2.width;
         _loc3_.height = param2.height;
         return true;
      }
      
      public function removeWidgetWindow(param1:String, param2:class_1741) : void
      {
         var _loc3_:class_1812 = getWidgetContainer(param1,param2);
         if(_loc3_ != null)
         {
            _loc3_.removeChild(param2);
         }
      }
      
      public function addRoomView(param1:class_1741) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:class_1812 = _layoutContainer.getChildByTag("room_view") as class_1812;
         if(_loc2_ == null)
         {
            return false;
         }
         _loc2_.addChild(param1);
         return true;
      }
      
      public function get roomViewRect() : Rectangle
      {
         if(_layoutContainer == null)
         {
            return null;
         }
         var _loc1_:class_1812 = _layoutContainer.findChildByTag("room_view") as class_1812;
         if(!_loc1_)
         {
            return null;
         }
         var _loc2_:Rectangle = _loc1_.rectangle;
         if(!_loc2_)
         {
            return null;
         }
         _loc2_.offset(_layoutContainer.x,_layoutContainer.y);
         return _loc2_;
      }
      
      public function getRoomView() : class_1741
      {
         if(_layoutContainer == null)
         {
            return null;
         }
         var _loc1_:class_1812 = _layoutContainer.findChildByTag("room_view") as class_1812;
         if(_loc1_ != null && _loc1_.numChildren > 0)
         {
            return _loc1_.getChildAt(0);
         }
         return null;
      }
      
      public function getChatContainer() : class_1970
      {
         if(_layoutContainer == null)
         {
            return null;
         }
         return _layoutContainer.findChildByTag("room_new_chat") as class_1970;
      }
   }
}

