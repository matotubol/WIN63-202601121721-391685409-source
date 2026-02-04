package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.userclassification.UserClassificationData;
   import com.sulake.habbo.util.VisitUserUtil;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class UserClassificationCtrl implements class_13, ITrackedWindow
   {
      
      private static var CLASSIFICATION_ROW_POOL_MAX_SIZE:int = 200;
      
      private static var CLASSIFICATION_ROW_POOL:Array = [];
      
      private var _main:ModerationManager;
      
      private var _frame:class_2250;
      
      private var var_121:IItemListWindow;
      
      private var var_3420:int;
      
      private var var_5179:Array;
      
      private var _disposed:Boolean;
      
      private var var_1339:class_1812;
      
      private var var_908:Timer;
      
      private var var_2571:Array = [];
      
      public function UserClassificationCtrl(param1:ModerationManager, param2:int)
      {
         super();
         _main = param1;
         var_3420 = param2;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         var_908 = new Timer(300,1);
         var_908.addEventListener("timer",onResizeTimer);
         _main.messageHandler.addUserClassificationListener(this);
         _frame = class_2250(_main.getXmlWindow("userclassification_frame"));
         var_121 = IItemListWindow(_frame.findChildByName("userclassification_list"));
         var_1339 = var_121.getListItemAt(0) as class_1812;
         var_121.removeListItems();
         _frame.procedure = onWindow;
         var _loc1_:class_1741 = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
      }
      
      public function onUserClassification(param1:int, param2:Array) : void
      {
         if(param1 != var_3420)
         {
            return;
         }
         if(_disposed)
         {
            return;
         }
         this.var_5179 = param2;
         _frame.caption = "";
         populate();
         onResizeTimer(null);
         _frame.visible = true;
         _main.messageHandler.removeUserClassificationListener(this);
      }
      
      private function populate() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = true;
         for each(_loc2_ in var_5179)
         {
            populateRoomRow(_loc2_,_loc1_);
            _loc1_ = !_loc1_;
         }
      }
      
      private function populateRoomRow(param1:UserClassificationData, param2:Boolean) : void
      {
         var _loc5_:class_1812 = getRoomRowWindow();
         var _loc3_:uint = param2 ? 4288861930 : 4294967295;
         _loc5_.color = _loc3_;
         var _loc6_:class_1741 = _loc5_.findChildByName("user_name_txt");
         _loc6_.caption = param1.username;
         _loc6_.color = _loc3_;
         var _loc4_:ITextWindow = ITextWindow(_loc5_.findChildByName("visit_room_txt"));
         _loc4_.color = _loc3_;
         var _loc7_:ITextWindow = ITextWindow(_loc5_.findChildByName("user_classification_txt"));
         _loc7_.text = param1.classType;
         if(!_main || !_main.isModerator)
         {
            _loc7_.visible = false;
            _loc4_.visible = false;
         }
         addClassificationRowToList(_loc5_,var_121);
         if(_main && _main.isModerator)
         {
            new OpenUserInfo(_frame,_main,_loc6_,param1.userId);
            new VisitUserUtil(_main,_loc4_,param1.userId);
         }
      }
      
      private function addClassificationRowToList(param1:class_1812, param2:IItemListWindow) : void
      {
         param2.addListItem(param1);
         var_2571.push(param1);
      }
      
      private function getRoomRowWindow() : class_1812
      {
         if(CLASSIFICATION_ROW_POOL.length > 0)
         {
            return CLASSIFICATION_ROW_POOL.pop() as class_1812;
         }
         return class_1812(var_1339.clone());
      }
      
      private function storeClassificationRowWindow(param1:class_1812) : void
      {
         var _loc3_:class_1741 = null;
         var _loc2_:class_1741 = null;
         if(CLASSIFICATION_ROW_POOL.length < CLASSIFICATION_ROW_POOL_MAX_SIZE)
         {
            _loc3_ = param1.findChildByName("user_name_txt");
            _loc3_.procedure = null;
            _loc2_ = param1.findChildByName("visit_room_txt");
            _loc2_.procedure = null;
            param1.width = var_1339.width;
            param1.height = var_1339.height;
            CLASSIFICATION_ROW_POOL.push(param1);
         }
         else
         {
            param1.dispose();
         }
      }
      
      private function onClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      private function onWindow(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WE_RESIZED" || param2 != _frame)
         {
            return;
         }
         if(!this.var_908.running)
         {
            this.var_908.reset();
            this.var_908.start();
         }
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         var _loc3_:class_1812 = class_1812(var_121.parent);
         var _loc5_:class_1741 = _loc3_.getChildByName("scroller") as class_1741;
         var _loc4_:* = var_121.scrollableRegion.height > var_121.height;
         if(_loc5_.visible)
         {
            if(!_loc4_)
            {
               _loc5_.visible = false;
               var_121.width += 17;
            }
         }
         else if(_loc4_)
         {
            _loc5_.visible = true;
            var_121.width -= 17;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_121 != null)
         {
            var_121.removeListItems();
            var_121.dispose();
            var_121 = null;
         }
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         _main = null;
         if(var_908 != null)
         {
            var_908.stop();
            var_908.removeEventListener("timer",onResizeTimer);
            var_908 = null;
         }
         for each(var _loc1_ in var_2571)
         {
            storeClassificationRowWindow(null);
         }
         if(var_1339 != null)
         {
            var_1339.dispose();
            var_1339 = null;
         }
         var_2571 = [];
      }
      
      public function getType() : int
      {
         return 6;
      }
      
      public function getId() : String
      {
         return "" + var_3420;
      }
      
      public function getFrame() : class_2250
      {
         return _frame;
      }
   }
}

