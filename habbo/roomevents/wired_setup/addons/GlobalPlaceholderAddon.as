package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedDropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.PlaceholderNameSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import flash.utils.Dictionary;
   import package_188.SharedGlobalPlaceholder;
   import package_188.SharedGlobalPlaceholderList;
   
   public class GlobalPlaceholderAddon extends DefaultAddonType
   {
      
      private var var_1414:PlaceholderNameSection;
      
      private var var_1307:RadioGroupPreset;
      
      private var var_2413:TextInputPreset;
      
      private var _roomDropdown:NamedDropdownPreset;
      
      private var _placeholderDropdown:NamedDropdownPreset;
      
      private var var_1384:SharedGlobalPlaceholderList;
      
      private var var_1592:String;
      
      public function GlobalPlaceholderAddon()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4074.GLOBAL_PLACEHOLDER;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var_1414 = param1.createPlaceholderNameSection(l("texts.placeholder_name"),"$");
         var_2413 = param1.createTextInput(new TextInputParam("",100));
         _roomDropdown = param1.createNamedDropdown(new DropdownParam(l("room_selection.tooltip"),null,initPlaceholdersForRoom),l("room_selection"));
         _placeholderDropdown = param1.createNamedDropdown(new DropdownParam(l("placeholder_selection.tooltip"),null,onPlaceholderSelected),l("placeholder_selection"));
         var_1307 = param1.createRadioGroup([new RadioButtonParam(0,l("from_value"),null,var_2413),new RadioButtonParam(1,l("from_another_room"),null,param1.createSimpleListView(true,[_roomDropdown,_placeholderDropdown]))]);
         var _loc4_:SectionPreset = param1.createSection(l("choose_type"),var_1307);
         param3.addElements(var_1414,_loc4_);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var_1592 = null;
         var _loc4_:int = param1.getInt(0);
         var _loc3_:String = param1.getString(0);
         var_1414.placeholderName = _loc3_;
         var_1384 = param1.wiredContext.referencePlaceholderList;
         var_1307.setOptionDisabled(1,var_1384 == null);
         var_1307.setOptionDisabled(0,var_1384 == null && _loc4_ == 1);
         var_1307.selected = _loc4_;
         _roomDropdown.reset();
         _placeholderDropdown.reset();
         if(_loc4_ == 0)
         {
            var_2413.text = param1.getString(1);
            if(var_1384 != null)
            {
               _roomDropdown.reinit(findRooms(),-1);
            }
         }
         else
         {
            var_2413.text = "";
            var _loc2_:String = param1.getString(1);
            var _loc5_:int = param1.getInt(2);
            _roomDropdown.reinit(findRooms(),0);
            initPlaceholdersForRoom(_roomDropdown.selected,null);
            var_1592 = _placeholderDropdown.selected?.displayString;
         }
      }
      
      private function initPlaceholdersForRoom(param1:ExpandableDropdownOption, param2:String = null) : void
      {
         if(param1 == null)
         {
            _placeholderDropdown.reset();
            return;
         }
         var _loc4_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         var _loc3_:int = -1;
         if(var_1384 != null)
         {
            for each(var _loc5_ in var_1384.sharedPlaceholders)
            {
               if(_loc5_.roomId == param1.id)
               {
                  if(param2 != null && _loc5_.placeholderName == param2)
                  {
                     _loc3_ = int(_loc4_.length);
                  }
                  _loc4_.push(new ExpandableDropdownOption(_loc4_.length,_loc5_.placeholderName));
               }
            }
         }
         _placeholderDropdown.reinit(_loc4_,_loc3_);
      }
      
      private function onPlaceholderSelected(param1:ExpandableDropdownOption) : void
      {
         if(var_1414.placeholderName.length == 0 || var_1592 != null && var_1592 == var_1414.placeholderName)
         {
            var_1414.placeholderName = param1?.displayString;
         }
         var_1592 = _placeholderDropdown.selected?.displayString;
      }
      
      private function findRooms() : Vector.<ExpandableDropdownOption>
      {
         var placeholder:SharedGlobalPlaceholder;
         var options:Dictionary = new Dictionary();
         var result:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         if(var_1384 != null)
         {
            for each(placeholder in var_1384.sharedPlaceholders)
            {
               if(!(placeholder.roomId in options))
               {
                  result.push(new ExpandableDropdownOption(placeholder.roomId,placeholder.roomName));
               }
               options[placeholder.roomId] = true;
            }
         }
         result.sort(function(param1:String, param2:String):int
         {
            return param1.localeCompare(param2);
         });
         return result;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [var_1307.selected,0,var_1307.selected == 0 ? 0 : _roomDropdown.selectedId];
      }
      
      override public function readStringParamFromForm() : String
      {
         var _loc1_:String = var_1414.placeholderName + "\t";
         if(var_1307.selected == 0)
         {
            _loc1_ += var_2413.text;
         }
         else if(_placeholderDropdown.selected != null)
         {
            _loc1_ += _placeholderDropdown.selected.displayString;
         }
         return _loc1_;
      }
   }
}

