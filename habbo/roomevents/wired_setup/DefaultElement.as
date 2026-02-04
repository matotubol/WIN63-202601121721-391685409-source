package com.sulake.habbo.roomevents.wired_setup
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.class_4050;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.class_2677;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import package_3.class_2022;
   
   public class DefaultElement implements class_2403
   {
      
      public static var INPUTS_TYPE_NONE:int = 0;
      
      public static var INPUTS_TYPE_LEGACY_UI:int = 1;
      
      public static var INPUTS_TYPE_UI_BUILDER:int = 2;
      
      private var _cont:class_1812;
      
      private var _advancedCont:class_1812;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_704:Boolean = false;
      
      public function DefaultElement()
      {
         super();
      }
      
      public function get code() : int
      {
         return -1;
      }
      
      public function get negativeCode() : int
      {
         return -1;
      }
      
      public function get hasStateSnapshot() : Boolean
      {
         return false;
      }
      
      public function readIntParamsFromForm() : Array
      {
         return [];
      }
      
      public function readVariableIdsFromForm() : Array
      {
         return [];
      }
      
      public function readStringParamFromForm() : String
      {
         return "";
      }
      
      public function setRoomEvents(param1:HabboUserDefinedRoomEvents) : void
      {
         _roomEvents = param1;
      }
      
      public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         _cont = param1;
         _advancedCont = param2;
         _roomEvents = param3;
         var_704 = true;
      }
      
      public function isInitialized() : Boolean
      {
         return var_704;
      }
      
      public function onEditStart(param1:class_2397) : void
      {
      }
      
      public function onEditInitialized() : void
      {
      }
      
      public function onEditEnd() : void
      {
      }
      
      public function validate() : String
      {
         return null;
      }
      
      public function onGuildMemberships(param1:class_2022) : void
      {
      }
      
      public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title";
      }
      
      public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.users.title";
      }
      
      public function get forceFurniSelection() : Boolean
      {
         return hasStateSnapshot;
      }
      
      public function mergedSelections() : Array
      {
         return [];
      }
      
      public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title";
      }
      
      public function setMergedType(param1:int, param2:int) : void
      {
      }
      
      public function getMergedType(param1:int) : int
      {
         return 0;
      }
      
      public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         return false;
      }
      
      public function getCustomSourcesForMergedType(param1:int) : Array
      {
         return [];
      }
      
      public function get forceHidePickFurniInstructions() : Boolean
      {
         return false;
      }
      
      public function advancedAlwaysVisible() : Boolean
      {
         return false;
      }
      
      public function get usingCustomAdvancedSettings() : Boolean
      {
         return false;
      }
      
      public function get requireConfirmation() : Object
      {
         return null;
      }
      
      public function get legacyInputMode() : Boolean
      {
         return false;
      }
      
      protected function get legacyAdvancedInputMode() : Boolean
      {
         return false;
      }
      
      public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
      }
      
      public function buildAdvancedInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
      }
      
      public function get inputMode() : int
      {
         if(legacyInputMode)
         {
            return INPUTS_TYPE_LEGACY_UI;
         }
         return INPUTS_TYPE_NONE;
      }
      
      public function get advancedInputMode() : int
      {
         if(legacyAdvancedInputMode)
         {
            return INPUTS_TYPE_LEGACY_UI;
         }
         return INPUTS_TYPE_NONE;
      }
      
      public function mergedSourceOptions(param1:int) : Array
      {
         var _loc3_:Array = [WiredInputSourcePicker.var_128,WiredInputSourcePicker.USER_SOURCE];
         for each(var _loc2_ in getCustomSourcesForMergedType(param1))
         {
            if(!(!_roomEvents.getBoolean("wired.variables.context_visible") && _loc2_ == class_4050.CONTEXT_SOURCE && getMergedType(param1) != class_4050.CONTEXT_SOURCE))
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function hasCustomTypePicker(param1:int) : Boolean
      {
         return false;
      }
      
      protected function createSourceTypeListener(param1:int) : class_2677
      {
         return new WrappedSourceTypeListener(this,param1);
      }
      
      protected function get cont() : class_1812
      {
         return _cont;
      }
      
      protected function get advancedCont() : class_1812
      {
         return _advancedCont;
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      protected function get roomEventsCtrl() : class_1928
      {
         return _roomEvents.wiredCtrl;
      }
      
      protected function loc(param1:String) : String
      {
         return _roomEvents.localization.getLocalization(param1,param1);
      }
      
      protected function l(param1:String) : String
      {
         return _roomEvents.localization.getLocalization("wiredfurni.params." + param1,param1);
      }
      
      public function get widthModifier() : Number
      {
         return 1;
      }
   }
}

