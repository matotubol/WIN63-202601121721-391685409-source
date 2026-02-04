package com.sulake.habbo.roomevents.wired_setup.common
{
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import flash.utils.Dictionary;
   import package_188.class_3414;
   import package_189.WiredVariable;
   import package_189.class_4013;
   
   public class VariablePicker
   {
      
      public static var UNSPECIFIED_TYPE:int = 2147483647;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_1453:class_3414;
      
      private var _dropdown:class_2261;
      
      private var var_1041:int;
      
      private var var_3743:Function;
      
      private var var_1313:Vector.<WiredVariable> = new Vector.<WiredVariable>();
      
      private var var_2534:Function;
      
      private var var_1897:Boolean = false;
      
      private var var_1350:Boolean = false;
      
      private var var_1947:Boolean = false;
      
      private var var_1009:String = WiredVariable.var_636;
      
      private var var_2465:Dictionary;
      
      public function VariablePicker(param1:HabboUserDefinedRoomEvents, param2:class_2261, param3:Function = null, param4:Function = null)
      {
         super();
         _roomEvents = param1;
         _dropdown = param2;
         var_3743 = param3;
         var_2534 = param4;
         _dropdown.addEventListener("WE_SELECTED",onSelectAction);
         _dropdown.addEventListener("WE_COLLAPSE",onDropdownCollapse);
      }
      
      public function init(param1:class_3414, param2:String, param3:int) : void
      {
         var_1453 = param1;
         var_1041 = param3;
         var_1947 = false;
         var_1897 = false;
         var_1350 = false;
         var_1009 = WiredVariable.var_636;
         var_2465 = new Dictionary();
         var_2465[param3] = param2;
         populate(param2);
      }
      
      public function reload(param1:String) : void
      {
         init(var_1453,param1,var_1041);
      }
      
      private function populate(param1:String, param2:Boolean = false) : void
      {
         var_1313.splice(0,var_1313.length);
         var _loc7_:Vector.<String> = new Vector.<String>();
         var_1897 = false;
         var _loc5_:int = 0;
         while(0 < var_1453.variables.length)
         {
            var _loc4_:WiredVariable = var_1453.variables[0];
            if((var_3743 == null || var_3743(null)) && null.variableName != "" && (null.variableTarget == var_1041 || var_1041 == UNSPECIFIED_TYPE))
            {
               if(!(null.isInvisible && param1 != null.variableId))
               {
                  if(param1 == null.variableId)
                  {
                     var _loc3_:int = int(var_1313.length);
                     if(null.variableType == class_4013.INTERNAL && !param2)
                     {
                        var_1350 = true;
                        populate(param1,true);
                        return;
                     }
                  }
                  if(null.variableType == class_4013.INTERNAL)
                  {
                     var_1897 = true;
                  }
                  if(null.variableType != class_4013.INTERNAL || param2)
                  {
                     var_1313.push(null);
                     _loc7_.push(null.variableName);
                  }
               }
            }
            _loc5_++;
         }
         if(var_1897 && !param2)
         {
            var _loc6_:String = "wiredfurni.params.variables.show_internal";
            _loc7_.push(_roomEvents.localization.getLocalization(null,null));
         }
         var_1947 = true;
         _dropdown.populateWithVector(_loc7_);
         var_1009 = WiredVariable.var_636;
      }
      
      private function onSelectAction(param1:class_1758) : void
      {
         if(_dropdown.selection >= var_1313.length)
         {
            var_1350 = true;
            populate(var_1009,true);
            _dropdown.openMenu();
            return;
         }
         var_1009 = selectedVariableId;
         if(var_2534 != null)
         {
            var_2534(selectedVariable);
         }
      }
      
      private function onDropdownCollapse(param1:class_1758) : void
      {
         if(var_1947)
         {
            var_1947 = false;
            return;
         }
         if(var_1350 && (selectedVariable == null || selectedVariable.variableType != class_4013.INTERNAL))
         {
            var_1350 = false;
            populate(selectedVariableId,false);
         }
      }
      
      public function set variableType(param1:int) : *
      {
         if(param1 != var_1041)
         {
            var_2465[var_1041] = selectedVariableId;
            var_1041 = param1;
            var _loc2_:String = WiredVariable.var_636;
            if(var_1041 in var_2465)
            {
               _loc2_ = var_2465[var_1041];
            }
            populate(null);
            if(var_2534 != null)
            {
               var_2534(selectedVariable);
            }
         }
      }
      
      public function get selectedVariable() : WiredVariable
      {
         var _loc1_:Number = _dropdown.selection;
         if(_loc1_ < 0 || _loc1_ >= var_1313.length)
         {
            return null;
         }
         return var_1313[_loc1_];
      }
      
      public function get selectedVariableId() : String
      {
         return selectedVariable?.variableId;
      }
   }
}

