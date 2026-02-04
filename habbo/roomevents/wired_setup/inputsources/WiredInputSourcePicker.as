package com.sulake.habbo.roomevents.wired_setup.inputsources
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.InputSourcesConf;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.*;
   import com.sulake.habbo.roomevents.wired_setup.common.class_4050;
   import flash.utils.Dictionary;
   
   public class WiredInputSourcePicker implements class_2677, class_13
   {
      
      public static var var_128:int = 0;
      
      public static var USER_SOURCE:int = 1;
      
      public static var MERGED_SOURCE:int = 2;
      
      public static var STUFF_PICKING_MODE_NONE:int = 0;
      
      public static var STUFF_PICKING_MODE_1:int = 1;
      
      public static var STUFF_PICKING_MODE_2:int = 2;
      
      private var _disposed:Boolean = false;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_815:int;
      
      private var var_197:int;
      
      private var var_255:class_2397;
      
      private var var_347:class_2403;
      
      private var _selectionCache:Dictionary;
      
      private var var_4854:String;
      
      private var var_3353:int;
      
      private var var_3989:Boolean;
      
      private var var_2482:Boolean;
      
      public function WiredInputSourcePicker(param1:HabboUserDefinedRoomEvents, param2:int, param3:int)
      {
         super();
         this._roomEvents = param1;
         this.var_815 = param2;
         this.var_197 = param3;
         if(var_815 == MERGED_SOURCE)
         {
            _selectionCache = new Dictionary();
         }
      }
      
      public static function getTypeNameForSource(param1:int) : String
      {
         if(param1 == var_128)
         {
            return "furni";
         }
         if(param1 == USER_SOURCE)
         {
            return "users";
         }
         if(param1 == class_4050.CONTEXT_SOURCE)
         {
            return "context";
         }
         if(param1 == class_4050.GLOBAL_SOURCE)
         {
            return "global";
         }
         return "";
      }
      
      public function onChangeInputSource(param1:Boolean) : void
      {
         var _loc9_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:InputSourcesConf = var_255.inputSourcesConf;
         if(var_815 == var_128)
         {
            _loc9_ = _loc4_.getAllowedFurniSources(var_197);
            _loc2_ = int(var_255.furniSourceTypes[var_197]);
            _loc3_ = int(_loc9_.indexOf(_loc2_));
         }
         else if(var_815 == USER_SOURCE)
         {
            _loc9_ = _loc4_.getAllowedUserSources(var_197);
            _loc2_ = int(var_255.userSourceTypes[var_197]);
            _loc3_ = int(_loc9_.indexOf(_loc2_));
         }
         else
         {
            _loc7_ = var_347.mergedSelections()[var_197];
            _loc5_ = int(_loc7_[0]);
            _loc6_ = int(_loc7_[1]);
            _loc8_ = var_347.getMergedType(var_197);
            if(_loc8_ == var_128)
            {
               _loc9_ = _loc4_.getAllowedFurniSources(_loc5_);
               _loc2_ = int(var_255.furniSourceTypes[_loc5_]);
               _loc3_ = int(_loc9_.indexOf(_loc2_));
            }
            else
            {
               if(_loc8_ != USER_SOURCE)
               {
                  return;
               }
               _loc9_ = _loc4_.getAllowedUserSources(_loc6_);
               _loc2_ = int(var_255.userSourceTypes[_loc6_]);
               _loc3_ = int(_loc9_.indexOf(_loc2_));
            }
         }
         if(_loc3_ == -1)
         {
            _loc3_ = 0;
         }
         else if(param1)
         {
            _loc3_ = (_loc3_ + 1) % _loc9_.length;
         }
         else
         {
            _loc3_ = (_loc3_ - 1 + _loc9_.length) % _loc9_.length;
         }
         if(var_815 == var_128)
         {
            var_255.furniSourceTypes[var_197] = _loc9_[_loc3_];
         }
         else if(var_815 == USER_SOURCE)
         {
            var_255.userSourceTypes[var_197] = _loc9_[_loc3_];
         }
         else if(_loc8_ == var_128)
         {
            var_255.furniSourceTypes[_loc5_] = _loc9_[_loc3_];
         }
         else if(_loc8_ == USER_SOURCE)
         {
            var_255.userSourceTypes[_loc6_] = _loc9_[_loc3_];
         }
         refreshContainer(var_255,var_347);
      }
      
      public function set sourceType(param1:int) : void
      {
         var _loc4_:int = 0;
         if(var_815 != MERGED_SOURCE)
         {
            return;
         }
         var _loc2_:int = var_347.getMergedType(var_197);
         var_347.setMergedType(var_197,param1);
         if(_loc2_ == var_128)
         {
            _selectionCache[_loc2_] = var_255.furniSourceTypes[var_197];
         }
         else if(_loc2_ == USER_SOURCE)
         {
            _selectionCache[_loc2_] = var_255.userSourceTypes[var_197];
         }
         var _loc3_:InputSourcesConf = var_255.inputSourcesConf;
         if(param1 == var_128)
         {
            _loc4_ = int(param1 in _selectionCache ? _selectionCache[param1] : _loc3_.getAllowedFurniSources(var_197)[0]);
            var_255.furniSourceTypes[var_197] = _loc4_;
         }
         else if(param1 == USER_SOURCE)
         {
            _loc4_ = int(param1 in _selectionCache ? _selectionCache[param1] : _loc3_.getAllowedUserSources(var_197)[0]);
            var_255.userSourceTypes[var_197] = _loc4_;
         }
         refreshContainer(var_255,var_347);
      }
      
      public function refreshContainer(param1:class_2397, param2:class_2403) : void
      {
         var _loc14_:int = 0;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc11_:int = 0;
         var _loc4_:String = null;
         if(var_255 != param1 || var_347 != param2)
         {
            var_255 = param1;
            var_347 = param2;
            if(var_815 == MERGED_SOURCE)
            {
               _selectionCache = new Dictionary();
            }
         }
         var _loc3_:Boolean = false;
         if(var_815 == var_128)
         {
            _loc9_ = "furni";
            _loc14_ = int(param1.furniSourceTypes[var_197]);
         }
         else if(var_815 == USER_SOURCE)
         {
            _loc9_ = "users";
            _loc14_ = int(param1.userSourceTypes[var_197]);
         }
         else
         {
            _loc10_ = param2.mergedSelections()[var_197];
            _loc7_ = int(_loc10_[0]);
            _loc8_ = int(_loc10_[1]);
            _loc11_ = param2.getMergedType(var_197);
            if(_loc11_ == var_128)
            {
               _loc9_ = "furni";
               _loc14_ = int(param1.furniSourceTypes[_loc7_]);
            }
            else if(_loc11_ == USER_SOURCE)
            {
               _loc9_ = "users";
               _loc14_ = int(param1.userSourceTypes[_loc8_]);
            }
            else
            {
               _loc3_ = true;
               _loc9_ = getTypeNameForSource(param2.getMergedType(var_197));
            }
         }
         if(_loc3_)
         {
            _loc4_ = "wiredfurni.params.sources." + _loc9_;
         }
         else
         {
            _loc4_ = "wiredfurni.params.sources." + _loc9_ + "." + _loc14_;
         }
         var _loc15_:String = _roomEvents.localization.getLocalization(_loc4_,_loc4_);
         var_3353 = STUFF_PICKING_MODE_NONE;
         if(_loc9_ == "furni")
         {
            var _loc13_:Boolean = param1.inputSourcesConf.isDualFurniPickingMode();
            var _loc6_:Boolean = wiredCtrl.hidePickFurniInstructions;
            var _loc5_:int = STUFF_PICKING_MODE_NONE;
            if(_loc14_ == 100)
            {
               var _loc12_:Array = wiredCtrl.getStuffIds();
               _loc5_ = STUFF_PICKING_MODE_1;
            }
            else if(_loc14_ == 101)
            {
               _loc12_ = wiredCtrl.getStuffIds2();
               _loc5_ = STUFF_PICKING_MODE_2;
            }
         }
         var_3989 = _loc3_;
         var_4854 = _loc15_;
         var_2482 = param2.isInputSourceDisabled(var_197,var_815);
      }
      
      public function get sourceType() : int
      {
         return var_815;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get selectedText() : String
      {
         return var_4854;
      }
      
      public function get isButtonsDisabled() : Boolean
      {
         return var_3989;
      }
      
      public function get stuffPickingSpecialMode() : int
      {
         return var_3353;
      }
      
      private function get wiredCtrl() : class_1928
      {
         return _roomEvents.wiredCtrl;
      }
      
      public function get disabled() : Boolean
      {
         return var_2482;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _roomEvents = null;
         var_255 = null;
         var_347 = null;
         _selectionCache = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

