package com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.class_1758;
   
   public class ExpandableDropdown implements class_13
   {
      
      private var _disposed:Boolean;
      
      private var _dropdown:class_2261;
      
      private var _onChangeCallback:Function;
      
      private var _advancedVisible:Boolean = false;
      
      private var var_1947:Boolean = false;
      
      private var var_1009:Number = 0;
      
      private var var_852:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
      
      private var var_2800:String;
      
      private var var_934:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
      
      public function ExpandableDropdown(param1:class_2261, param2:String, param3:Function = null)
      {
         super();
         _dropdown = param1;
         var_2800 = param2;
         _onChangeCallback = param3;
         _dropdown.addEventListener("WE_SELECTED",onSelectAction);
         _dropdown.addEventListener("WE_COLLAPSE",onDropdownCollapse);
      }
      
      public function init(param1:Vector.<ExpandableDropdownOption>, param2:int) : void
      {
         var_852 = param1;
         var_1947 = false;
         _advancedVisible = false;
         var_1009 = 0;
         populate(param2);
      }
      
      private function populate(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:int = -1;
         var_934.splice(0,var_934.length);
         var _loc4_:Vector.<String> = new Vector.<String>();
         for each(var _loc5_ in var_852)
         {
            if(param1 == _loc5_.id)
            {
               _loc3_ = int(var_934.length);
               if(_loc5_.isAdvanced && !param2)
               {
                  _advancedVisible = true;
                  populate(param1,true);
                  return;
               }
            }
            if(!_loc5_.isAdvanced || param2)
            {
               var_934.push(_loc5_);
               _loc4_.push(_loc5_.displayString);
            }
         }
         if(advancedOptionsAvailable && !param2)
         {
            _loc4_.push(var_2800);
         }
         var_1947 = true;
         _dropdown.populateWithVector(_loc4_);
         if(_loc3_ != -1)
         {
            _dropdown.selection = _loc3_;
            var_1009 = param1;
         }
         else
         {
            var_1009 = -1;
         }
      }
      
      private function get advancedOptionsAvailable() : Boolean
      {
         for each(var _loc1_ in var_852)
         {
            if(_loc1_.isAdvanced)
            {
               return true;
            }
         }
         return false;
      }
      
      private function onSelectAction(param1:class_1758) : void
      {
         if(_dropdown.selection >= var_934.length)
         {
            _advancedVisible = true;
            populate(var_1009,true);
            _dropdown.openMenu();
            return;
         }
         var_1009 = selectedOptionId;
         if(_onChangeCallback != null)
         {
            _onChangeCallback(selectedOption);
         }
      }
      
      private function onDropdownCollapse(param1:class_1758) : void
      {
         if(var_1947)
         {
            var_1947 = false;
            return;
         }
         if(_advancedVisible && (selectedOption == null || !selectedOption.isAdvanced))
         {
            _advancedVisible = false;
            populate(selectedOptionId,false);
         }
      }
      
      public function get selectedOption() : ExpandableDropdownOption
      {
         var _loc1_:Number = _dropdown.selection;
         if(_loc1_ < 0 || _loc1_ >= var_934.length)
         {
            return null;
         }
         return var_934[_loc1_];
      }
      
      public function get selectedOptionId() : Number
      {
         return selectedOption?.id;
      }
      
      public function set selectedOptionId(param1:Number) : void
      {
         init(var_852,param1);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _dropdown.dispose();
         _dropdown = null;
         _onChangeCallback = null;
         var_852 = null;
         var_2800 = null;
         var_934 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

