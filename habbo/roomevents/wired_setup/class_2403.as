package com.sulake.habbo.roomevents.wired_setup
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import package_3.class_2022;
   
   public interface class_2403
   {
      
      function get code() : int;
      
      function get negativeCode() : int;
      
      function setRoomEvents(param1:HabboUserDefinedRoomEvents) : void;
      
      function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void;
      
      function isInitialized() : Boolean;
      
      function onEditStart(param1:class_2397) : void;
      
      function onEditInitialized() : void;
      
      function onEditEnd() : void;
      
      function readIntParamsFromForm() : Array;
      
      function readVariableIdsFromForm() : Array;
      
      function readStringParamFromForm() : String;
      
      function get hasStateSnapshot() : Boolean;
      
      function validate() : String;
      
      function get inputMode() : int;
      
      function get advancedInputMode() : int;
      
      function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void;
      
      function buildAdvancedInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void;
      
      function furniSelectionTitle(param1:int) : String;
      
      function userSelectionTitle(param1:int) : String;
      
      function get forceFurniSelection() : Boolean;
      
      function mergedSelections() : Array;
      
      function mergedSelectionTitle(param1:int) : String;
      
      function setMergedType(param1:int, param2:int) : void;
      
      function getMergedType(param1:int) : int;
      
      function mergedSourceOptions(param1:int) : Array;
      
      function hasCustomTypePicker(param1:int) : Boolean;
      
      function isInputSourceDisabled(param1:int, param2:int) : Boolean;
      
      function getCustomSourcesForMergedType(param1:int) : Array;
      
      function get forceHidePickFurniInstructions() : Boolean;
      
      function advancedAlwaysVisible() : Boolean;
      
      function get usingCustomAdvancedSettings() : Boolean;
      
      function onGuildMemberships(param1:class_2022) : void;
      
      function get requireConfirmation() : Object;
      
      function get legacyInputMode() : Boolean;
      
      function get roomEvents() : HabboUserDefinedRoomEvents;
      
      function get widthModifier() : Number;
   }
}

