package com.sulake.habbo.roomevents.wired_menu.tabs.common
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.InteractiveController;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class VariableTypePicker implements class_13, class_31
   {
      
      private static var SELECTION_TYPES:* = ["furni","user","global","context"];
      
      private var _disposed:Boolean = false;
      
      private var _container:class_1812;
      
      private var _onSelectCallback:Function;
      
      private var _selected:String;
      
      private var var_2414:int;
      
      public function VariableTypePicker(param1:class_1812, param2:Function)
      {
         super();
         _container = param1;
         _onSelectCallback = param2;
         setMode(SELECTION_TYPES[0],true);
         for each(var _loc4_ in SELECTION_TYPES)
         {
            var _loc3_:InteractiveController = InteractiveController(getButton(_loc4_));
         }
      }
      
      private function maybeCancelEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_1775 = param1.target as class_1775;
         if(_loc2_ != null)
         {
            if(param1.type == "WME_OUT" && _loc2_.id == var_2414)
            {
               param1.preventWindowOperation();
            }
            if(param1.type == "WME_UP")
            {
               setMode(getButtonTypeName(_loc2_));
               param1.preventWindowOperation();
            }
         }
      }
      
      private function getButtonTypeName(param1:class_1775) : String
      {
         return param1.name.split("_")[1];
      }
      
      private function setMode(param1:String, param2:Boolean = false) : void
      {
         _selected = param1;
         for each(var _loc4_ in SELECTION_TYPES)
         {
            var _loc3_:InteractiveController = InteractiveController(getButton(_loc4_));
         }
         _loc3_ = InteractiveController(getButton(_selected));
         if(null.id != var_2414)
         {
            var_2414 = null.id;
            if(!param2)
            {
               _onSelectCallback(var_2414);
            }
         }
      }
      
      public function get selectedType() : int
      {
         return var_2414;
      }
      
      public function set selectedType(param1:int) : void
      {
         var _loc2_:class_1775 = null;
         for each(var _loc3_ in SELECTION_TYPES)
         {
            _loc2_ = getButton(_loc3_);
            if(_loc2_ != null)
            {
               if(_loc2_.id == param1)
               {
                  setMode(getButtonTypeName(_loc2_),true);
               }
            }
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:InteractiveController = null;
         if(_container)
         {
            for each(var _loc3_ in SELECTION_TYPES)
            {
               _loc2_ = InteractiveController(getButton(_loc3_));
               if(_loc2_ != null)
               {
                  if(_selected == _loc3_ && (_loc2_.state & 0x10) == 0)
                  {
                     _loc2_.state |= 16;
                  }
               }
            }
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _container = null;
         _onSelectCallback = null;
         _selected = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function getButton(param1:String) : class_1775
      {
         return _container.findChildByName("type_" + param1 + "_button") as class_1775;
      }
   }
}

