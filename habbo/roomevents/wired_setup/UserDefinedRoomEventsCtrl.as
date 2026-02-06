package com.sulake.habbo.roomevents.wired_setup
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.events.*;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.InputSourcesConf;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.SelectorDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2531;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3034;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3042;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3153;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3381;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3525;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateSelectorMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateTriggerMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateAddonMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateActionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.ApplySnapshotMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateVariableMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateConditionMessageComposer;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.WiredVariablesSynchronizer;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.ActionType;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.ActionTypes;
   import com.sulake.habbo.roomevents.wired_setup.addons.AddonTypes;
   import com.sulake.habbo.roomevents.wired_setup.conditions.ConditionTypes;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.selectors.SelectorTypes;
   import com.sulake.habbo.roomevents.wired_setup.triggerconfs.TriggerConfs;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilderMock;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.AdvancedSettingsWrapperPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.FooterPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.FramePreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.HeaderPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.InputSourceSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.LegacyInputWrapperPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.IlluminaWiredStyle;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.VolterBlueWiredStyle;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.VolterGreenWiredStyle;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.VolterWiredStyle;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.VolterYellowWiredStyle;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import com.sulake.habbo.roomevents.wired_setup.variables.VariableTypes;
   import com.sulake.habbo.roomevents.wired_setup.variables.class_2404;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.utils.Dictionary;
   import package_188.AllVariablesInRoom;
   import package_189.WiredVariable;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;
   
   public class UserDefinedRoomEventsCtrl implements class_1928
   {
      
      public static const UPDATE_MODE_NORMAL:int = 0;
      
      public static const const_475:int = 1;
      
      public static const UPDATE_MODE_SAVE_INTO_OTHER:int = 2;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_5028:TriggerConfs = new TriggerConfs();
      
      private var var_4447:ActionTypes = new ActionTypes();
      
      private var var_4640:ConditionTypes = new ConditionTypes();
      
      private var var_5031:AddonTypes = new AddonTypes();
      
      private var var_4892:SelectorTypes = new SelectorTypes();
      
      private var var_4050:VariableTypes = new VariableTypes();
      
      private var var_1566:Boolean = false;
      
      private var var_1147:int = 1;
      
      private var _stuffs1:Dictionary = new Dictionary();
      
      private var _stuffs2:Dictionary = new Dictionary();
      
      private var var_20:class_2397;
      
      private var var_62:class_2403;
      
      private var var_803:RoomObjectHighLighter;
      
      private var var_3916:Boolean = false;
      
      private var _variablesCallback:Function = null;
      
      private var var_649:class_55;
      
      private var var_1619:WiredStyle;
      
      private var var_182:PresetManager;
      
      private var _configurationCache:Dictionary = new Dictionary();
      
      private var var_3247:Dictionary = new Dictionary();
      
      private var var_1314:int = 0;
      
      private var var_3476:int = -2147483648;
      
      private var var_4025:int = -2147483648;
      
      private var var_2848:class_1812 = null;
      
      private var var_3098:class_1812 = null;
      
      private var _frame:FramePreset;
      
      private var _headerPreset:HeaderPreset;
      
      private var _selectorOptionsPreset:CheckboxGroupPreset;
      
      private var _furniPicksSectionPreset:SectionPreset;
      
      private var _delayPreset:SliderSection;
      
      private var _advancedSettingsWrapperPreset:AdvancedSettingsWrapperPreset;
      
      private var var_479:RadioGroupPreset;
      
      private var var_245:Vector.<InputSourceSection>;
      
      private var _footerPreset:FooterPreset;
      
      public function UserDefinedRoomEventsCtrl(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
         var_803 = new RoomObjectHighLighter(param1);
         var_182 = new PresetManager(param1);
         var_649 = new class_55();
         var_649.add("volter",new VolterWiredStyle(param1));
         var_649.add("illumina",new IlluminaWiredStyle(param1));
         var_649.add("volter_yellow",new VolterYellowWiredStyle(param1));
         var_649.add("volter_blue",new VolterBlueWiredStyle(param1));
         var_649.add("volter_green",new VolterGreenWiredStyle(param1));
         var_1619 = new VolterWiredStyle(param1);
      }
      
      public function stuffAdded(param1:int) : void
      {
         if(activeStuffsDictionary[param1])
         {
            var_803.show(param1,var_1566,var_1147);
         }
      }
      
      public function stuffSelected(param1:int) : void
      {
         if(_frame == null || var_20 == null)
         {
            return;
         }
         if(_frame.isCopyingIntoMode)
         {
            return;
         }
         if(!isStuffSelectionMode() || !var_20.allowWallFurni && param1 < 0)
         {
            return;
         }
         if(activeStuffsDictionary[param1])
         {
            delete activeStuffsDictionary[param1];
            var_803.hide(param1,var_1566,var_1147);
         }
         else if(activeStuffsArray.length < var_20.furniLimit)
         {
            activeStuffsDictionary[param1] = true;
            var_803.show(param1,var_1566,var_1147);
         }
         onStuffsChanged();
      }
      
      private function isStuffSelectionMode() : Boolean
      {
         return var_20 && (var_20.inputSourcesConf.allowFurniSelection() || var_62.forceFurniSelection);
      }
      
      public function get hidePickFurniInstructions() : Boolean
      {
         if(var_20 == null)
         {
            return false;
         }
         if(var_62.forceHidePickFurniInstructions)
         {
            return true;
         }
         return !var_20.inputSourcesConf.isFurniSelectionDefault() && !var_62.forceFurniSelection;
      }
      
      private function resolveHolder() : class_2510
      {
         return resolveHolderFor(var_20);
      }
      
      private function resolveHolderFor(param1:class_2397) : class_2510
      {
         if(param1 as class_3034 != null)
         {
            return var_5028;
         }
         if(param1 as class_3042 != null)
         {
            return var_4447;
         }
         if(param1 as class_2531 != null)
         {
            return var_4640;
         }
         if(param1 as class_3525 != null)
         {
            return var_5031;
         }
         if(param1 as SelectorDefinition != null)
         {
            return var_4892;
         }
         if(param1 as class_3381 != null)
         {
            return var_4050;
         }
         return null;
      }
      
      private function determineActiveWiredStyle() : WiredStyle
      {
         if(var_20 == null)
         {
            return var_649["volter"];
         }
         var _loc2_:class_1800 = _roomEvents.sessionDataManager.getFloorItemData(var_20.stuffTypeId);
         if(_loc2_ == null)
         {
            return var_649["volter"];
         }
         var _loc1_:String = _loc2_.className;
         if(_loc1_ == "wf_ltdproto_act_toggle_state")
         {
            return var_649.getValue("volter_yellow");
         }
         if(_loc1_ == "wf_proto_trg_at_given_time")
         {
            return var_649.getValue("volter_blue");
         }
         if(_loc1_ == "wf_proto_cnd_trggrer_on_frn")
         {
            return var_649.getValue("volter_green");
         }
         return var_649["volter"];
      }
      
      private function getCacheKey(param1:class_2510, param2:class_2397) : String
      {
         return param1.getKey() + "-" + var_1619.name + "-" + param1.getElementByCode(param2.code).code;
      }
      
      private function loadFromCache(param1:class_2510, param2:class_2397) : Boolean
      {
         var _loc4_:String = getCacheKey(param1,param2);
         if(_loc4_ in _configurationCache)
         {
            var _loc3_:WiredConfigurationCache = _configurationCache[_loc4_];
            _frame = null.frame;
            _headerPreset = null.headerPreset;
            _selectorOptionsPreset = null.selectorOptionsPreset;
            _furniPicksSectionPreset = null.furniPicksSectionPreset;
            _delayPreset = null.delayPreset;
            _advancedSettingsWrapperPreset = null.advancedSettingsWrapperPreset;
            var_479 = null.conditionQuantifierOptions;
            var_245 = null.inputSourcePresets;
            _footerPreset = null.footerPreset;
            return true;
         }
         return false;
      }
      
      private function storeInCache(param1:class_2510, param2:class_2397) : void
      {
         var _loc4_:String = getCacheKey(param1,param2);
         var _loc3_:WiredConfigurationCache = new WiredConfigurationCache(_frame,_headerPreset,_selectorOptionsPreset,_furniPicksSectionPreset,_delayPreset,_advancedSettingsWrapperPreset,var_479,var_245,_footerPreset);
         _configurationCache[_loc4_] = _loc3_;
      }
      
      private function createWindow() : Boolean
      {
         if(this._frame != null)
         {
            return false;
         }
         var _loc2_:class_2510 = resolveHolder();
         if(_loc2_ == null || var_20 == null || var_62 == null)
         {
            return false;
         }
         if(useCache && loadFromCache(_loc2_,var_20))
         {
            showFrame();
            return true;
         }
         var_2848 = null;
         var_3098 = null;
         var _loc1_:WiredUIBuilder = new WiredUIBuilder(_roomEvents,close,_loc2_.getKey(),var_62.code,isResizeEnabled);
         createHeader(var_20,_loc2_,var_62,_loc1_);
         createInputs(var_20,_loc2_,var_62,false,_loc1_);
         createSelectorOptions(var_20,_loc2_,var_62,_loc1_);
         createFurniPicks(var_20,_loc2_,var_62,_loc1_);
         createDelaySection(var_20,_loc2_,var_62,_loc1_);
         createAdvancedSections(var_20,_loc2_,var_62,_loc1_);
         createFooter(var_20,_loc2_,var_62,_loc1_);
         _loc1_.build(var_62.widthModifier);
         _frame = _loc1_.frame;
         var_62.onInit(var_2848,var_3098,_roomEvents);
         showFrame();
         if(useCache)
         {
            storeInCache(_loc2_,var_20);
         }
         return true;
      }
      
      private function showFrame() : void
      {
         var _loc1_:class_2052 = _roomEvents.windowManager.getDesktop(1);
         if(_loc1_ != null)
         {
            _loc1_.addChild(_frame.window);
         }
         _frame.window.center();
         _frame.window.activate();
      }
      
      private function hideFrame() : void
      {
         var _loc1_:class_2052 = null;
         if(_frame != null)
         {
            _loc1_ = _roomEvents.windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_frame.window);
            }
         }
      }
      
      private function createHeader(param1:class_2397, param2:class_2510, param3:class_2403, param4:WiredUIBuilder) : void
      {
         var _loc6_:int = 0;
         if(param3.hasStateSnapshot)
         {
            _loc6_ = 1;
         }
         var _loc5_:class_2404 = param3 as class_2404;
         if(_roomEvents.wiredMenu.isEnabled && _loc5_ != null)
         {
            _loc6_ = 2;
         }
         _headerPreset = var_182.createHeaderPreset(getElementName(var_20.stuffTypeId),param2,_loc6_,applySnapshot,viewVariableInMenu);
         param4.addElements(_headerPreset);
      }
      
      private function createInputs(param1:class_2397, param2:class_2510, param3:class_2403, param4:Boolean, param5:WiredUIBuilder) : void
      {
         var _loc6_:int = param4 ? param3.advancedInputMode : param3.inputMode;
         if(_loc6_ == DefaultElement.INPUTS_TYPE_LEGACY_UI)
         {
            var _loc7_:LegacyInputWrapperPreset = var_182.createLegacyInputWrapperPreset(param2.getKey(),param3.code,param4);
            param5.addElements(null);
            if(param4)
            {
               var_3098 = null.window as class_1812;
            }
            else
            {
               var_2848 = null.window as class_1812;
            }
         }
         else if(_loc6_ == DefaultElement.INPUTS_TYPE_UI_BUILDER)
         {
            param3.setRoomEvents(_roomEvents);
            if(param4)
            {
               param3.buildAdvancedInputs(var_182,var_1619,param5);
            }
            else
            {
               param3.buildInputs(var_182,var_1619,param5);
            }
         }
      }
      
      private function createSelectorOptions(param1:class_2397, param2:class_2510, param3:class_2403, param4:WiredUIBuilder) : void
      {
         var _loc6_:SelectorDefinition = param1 as SelectorDefinition;
         var _loc5_:* = _loc6_ != null;
         if(!_loc5_)
         {
            return;
         }
         _selectorOptionsPreset = var_182.createCheckboxGroup([new CheckboxOptionParam("${wiredfurni.params.selector_option.0}"),new CheckboxOptionParam("${wiredfurni.params.selector_option.1}")]);
         var _loc7_:SectionPreset = var_182.createSection("${wiredfurni.params.selector_options_selector}",_selectorOptionsPreset);
         param4.addElements(_loc7_);
      }
      
      private function createFurniPicks(param1:class_2397, param2:class_2510, param3:class_2403, param4:WiredUIBuilder) : void
      {
         if(!isStuffSelectionMode() || hidePickFurniInstructions)
         {
            return;
         }
         _furniPicksSectionPreset = var_182.createSection("${wiredfurni.pickfurnis.caption}",var_182.createText("${wiredfurni.pickfurnis.desc}",TextParam.DEFAULT));
         param4.addElements(_furniPicksSectionPreset);
      }
      
      private function createDelaySection(param1:class_2397, param2:class_2510, param3:class_2403, param4:WiredUIBuilder) : void
      {
         var _loc6_:class_3042 = param1 as class_3042;
         var _loc5_:ActionType = param3 as ActionType;
         if(_loc6_ == null || _loc5_ == null || !_loc5_.allowDelaying)
         {
            return;
         }
         _delayPreset = var_182.createSliderSection("wiredfurni.params.delay","seconds",SliderSection.CONVERTER_PULSES,0,20,1,false);
         param4.addElements(_delayPreset);
      }
      
      private function getQuantifierKey(param1:class_2531) : String
      {
         var _loc2_:int = param1.quantifierType;
         var _loc4_:String = _loc2_ == class_3153.var_5351 ? "furni" : (_loc2_ == class_3153.var_5310 ? "users" : (_loc2_ == class_3153.var_5360 ? "variables" : ""));
         _loc4_ = _loc4_ + (param1.isInvert ? ".neg." : ".");
         return "wiredfurni.params.quantifier." + _loc4_;
      }
      
      private function createAdvancedSections(param1:class_2397, param2:class_2510, param3:class_2403, param4:WiredUIBuilder) : void
      {
         var _loc7_:* = null;
         var _loc9_:WiredUIBuilderMock = null;
         var _loc8_:InputSourcesConf = param1.inputSourcesConf;
         var _loc5_:* = _loc8_.amountFurniSelections > 0;
         var _loc16_:* = _loc8_.amountUserSelections > 0;
         var _loc14_:class_2531 = param1 as class_2531;
         var _loc11_:Boolean = _loc14_ != null && _loc14_.quantifierType != class_3153.var_5241;
         var _loc6_:* = param3.advancedInputMode != DefaultElement.INPUTS_TYPE_NONE;
         var _loc15_:Boolean = param1.advancedMode && (_loc5_ || _loc16_ || _loc11_ || _loc6_);
         if(!_loc15_)
         {
            return;
         }
         var _loc10_:Array = [];
         if(_loc11_)
         {
            var _loc17_:String = getQuantifierKey(_loc14_);
            var_479 = var_182.createRadioGroup([new RadioButtonParam(0,"${" + null + 0 + "}"),new RadioButtonParam(1,"${" + null + 1 + "}")]);
            var _loc13_:SectionPreset = var_182.createSection("${wiredfurni.params.quantifier_selection}",var_479);
            _loc10_.push(null);
         }
         createAdvancedInputSources(param1,param2,param3);
         for each(_loc7_ in var_245)
         {
            _loc10_.push(_loc7_);
         }
         if(_loc6_)
         {
            _loc9_ = new WiredUIBuilderMock(_roomEvents);
            createInputs(param1,param2,param3,true,_loc9_);
            for each(_loc7_ in _loc9_.buildingElements)
            {
               _loc10_.push(_loc7_);
            }
         }
         var _loc12_:Boolean = param3.advancedAlwaysVisible();
         _advancedSettingsWrapperPreset = var_182.createAdvancedSettingsWrapperPreset(_loc10_,_loc12_);
         param4.addElements(_advancedSettingsWrapperPreset);
      }
      
      private function createAdvancedInputSources(param1:class_2397, param2:class_2510, param3:class_2403) : void
      {
         var _loc5_:InputSourcesConf = param1.inputSourcesConf;
         var_245 = new Vector.<InputSourceSection>();
         var _loc7_:Array = param3.mergedSelections();
         var _loc4_:Array = [];
         var _loc6_:Array = [];
         for each(var _loc8_ in _loc7_)
         {
            _loc4_.push(_loc8_[0]);
            _loc6_.push(_loc8_[1]);
         }
         var _loc9_:int = 0;
         while(0 < _loc5_.amountFurniSelections)
         {
            if(_loc4_.indexOf(0) == -1)
            {
               var _loc11_:String = "${" + param3.furniSelectionTitle(0) + "}";
               var _loc10_:InputSourceSection = var_182.createInputSourceSection(null,WiredInputSourcePicker.var_128,0,null,false,param1.inputSourcesConf.isDualFurniPickingMode());
               var_245.push(null);
            }
            _loc9_++;
         }
         _loc9_ = 0;
         while(0 < _loc5_.amountUserSelections)
         {
            if(_loc6_.indexOf(0) == -1)
            {
               _loc11_ = "${" + param3.userSelectionTitle(0) + "}";
               _loc10_ = var_182.createInputSourceSection(null,WiredInputSourcePicker.USER_SOURCE,0);
               var_245.push(null);
            }
            _loc9_++;
         }
         _loc9_ = 0;
         while(0 < _loc7_.length)
         {
            _loc11_ = "${" + param3.mergedSelectionTitle(0) + "}";
            _loc10_ = var_182.createInputSourceSection(null,WiredInputSourcePicker.MERGED_SOURCE,0,param3.mergedSourceOptions(0),param3.hasCustomTypePicker(0),param1.inputSourcesConf.isDualFurniPickingMode());
            var_245.push(null);
            _loc9_++;
         }
      }
      
      private function createFooter(param1:class_2397, param2:class_2510, param3:class_2403, param4:WiredUIBuilder) : void
      {
         _footerPreset = var_182.createFooterPreset(save,close);
         param4.addElements(_footerPreset);
      }
      
      private function fixQuantifierNames() : void
      {
         var _loc1_:class_2531 = null;
         var _loc2_:String = null;
         if(var_479 != null)
         {
            _loc1_ = var_20 as class_2531;
            if(_loc1_ == null)
            {
               return;
            }
            _loc2_ = getQuantifierKey(_loc1_);
            var_479.method_20(0).text = "${" + _loc2_ + 0 + "}";
            var_479.method_20(1).text = "${" + _loc2_ + 1 + "}";
         }
      }
      
      private function onEditStartUpdateCommonUI() : void
      {
         _headerPreset.updateName(getElementName(var_20.stuffTypeId));
         var _loc1_:SelectorDefinition = var_20 as SelectorDefinition;
         if(_selectorOptionsPreset != null && _loc1_ != null)
         {
            _selectorOptionsPreset.method_20(0).selected = _loc1_.isFilter;
            _selectorOptionsPreset.method_20(1).selected = _loc1_.isInvert;
         }
         onStuffsChanged();
         var _loc3_:class_3042 = var_20 as class_3042;
         if(_delayPreset != null && _loc3_ != null)
         {
            _delayPreset.value = _loc3_.delayInPulses;
         }
         var _loc2_:Boolean = var_20.advancedMode && (isUsingAdvancedSettings || var_62.advancedAlwaysVisible());
         if(_advancedSettingsWrapperPreset != null)
         {
            _advancedSettingsWrapperPreset.expanded = _loc2_;
         }
         var _loc5_:class_2531 = var_20 as class_2531;
         if(_loc5_ != null && _loc5_.quantifierType != class_3153.var_5241 && var_479 != null)
         {
            var_479.selected = _loc5_.quantifierCode;
            fixQuantifierNames();
         }
         if(var_245 != null)
         {
            for each(var _loc4_ in var_245)
            {
               _loc4_.refresh(var_20,var_62);
               if(_loc4_.baseSourceType == WiredInputSourcePicker.MERGED_SOURCE)
               {
                  _loc4_.sourceType = var_62.getMergedType(_loc4_.id);
               }
            }
         }
         _footerPreset.saveButtonDisabled = !_roomEvents.wiredMenu.hasWritePermission;
         _frame.refreshForNewTriggerable();
      }
      
      private function get activeStuffsDictionary() : Dictionary
      {
         if(!var_1566 || var_1147 == 1)
         {
            return _stuffs1;
         }
         return _stuffs2;
      }
      
      private function get activeStuffsArray() : Array
      {
         if(!var_1566 || var_1147 == 1)
         {
            return getStuffIds();
         }
         return getStuffIds2();
      }
      
      public function set activeFurniPicks(param1:int) : void
      {
         var_1147 = param1;
         if(var_245 != null)
         {
            for each(var _loc2_ in var_245)
            {
               _loc2_.activeFurniPicksChanged();
            }
         }
      }
      
      public function get activeFurniPicks() : int
      {
         return var_1147;
      }
      
      private function hideFurniHighlights() : void
      {
         var_803.hideAll(_stuffs1,true,1);
         var_803.hideAll(_stuffs2,true,2);
      }
      
      public function close() : void
      {
         if(var_20 != null)
         {
            var_803.unhighlightActiveWired(var_20.id);
            var_62.onEditEnd();
            var_20 = null;
            var_62 = null;
         }
         hideFurniHighlights();
         _stuffs1 = new Dictionary();
         _stuffs2 = new Dictionary();
         if(_frame)
         {
            savePosition();
            hideFrame();
            _headerPreset = null;
            _selectorOptionsPreset = null;
            _furniPicksSectionPreset = null;
            _delayPreset = null;
            _footerPreset = null;
            var_479 = null;
            _advancedSettingsWrapperPreset = null;
            var_245 = null;
            if(!useCache)
            {
               _frame.dispose();
            }
            _frame = null;
         }
         if(_variablesCallback != null)
         {
            _roomEvents.variablesSynchronizer.removeListener(_variablesCallback);
            _variablesCallback = null;
         }
      }
      
      private function synchronizeTriggerable(param1:class_2397) : Boolean
      {
         var synchronizer:WiredVariablesSynchronizer;
         var updated:class_2397 = param1;
         var variablesList:AllVariablesInRoom = updated.wiredContext.roomVariablesList;
         if(variablesList != null && variablesList.needsSynchronize)
         {
            synchronizer = _roomEvents.variablesSynchronizer;
            if(_variablesCallback != null)
            {
               synchronizer.removeListener(_variablesCallback);
            }
            _variablesCallback = function(param1:Vector.<WiredVariable>):void
            {
               _variablesCallback = null;
               updated.wiredContext.roomVariablesList.synchronize(param1);
               prepareForUpdate(updated);
            };
            synchronizer.getAllVariables(_variablesCallback,true,variablesList.hash);
            return true;
         }
         return false;
      }
      
      private function savePosition() : void
      {
         if(_frame == null)
         {
            return;
         }
         var_3476 = _frame.window.x;
         var_4025 = _frame.window.y;
      }
      
      private function restorePositionAndActivate() : void
      {
         if(_frame == null)
         {
            return;
         }
         if(var_3476 == -2147483648)
         {
            _frame.window.center();
         }
         else
         {
            _frame.window.x = var_3476;
            _frame.window.y = var_4025;
         }
         _frame.window.activate();
      }
      
      public function prepareForUpdate(param1:class_2397) : void
      {
         var _loc3_:class_2510 = null;
         var _loc5_:class_2403 = null;
         if(_frame != null && var_62 != null && _frame.isCopyingIntoMode)
         {
            _loc3_ = resolveHolderFor(param1);
            _loc5_ = _loc3_.getElementByCode(param1.code);
            if(_loc5_ == var_62)
            {
               update(2,param1.id);
            }
            else
            {
               _roomEvents.notifications.addItem("${notification.wired.pasted_into_fail}","wired");
            }
            return;
         }
         if(synchronizeTriggerable(param1))
         {
            return;
         }
         if(_frame)
         {
            close();
         }
         var_20 = param1;
         var_1619 = determineActiveWiredStyle();
         var_1566 = param1.inputSourcesConf.isDualFurniPickingMode();
         var_1147 = 1;
         var_62 = resolveHolder().getElementByCode(var_20.code);
         if(!createWindow())
         {
            var_20 = null;
            var_62 = null;
            return;
         }
         class_21.log("Received: " + var_20 + ", " + param1.code);
         var_803.highlightActiveWired(var_20.id);
         hideFurniHighlights();
         _stuffs1 = new Dictionary();
         _stuffs2 = new Dictionary();
         for each(var _loc2_ in var_20.stuffIds)
         {
            _stuffs1[_loc2_] = true;
         }
         for each(var _loc4_ in var_20.stuffIds2)
         {
            _stuffs2[_loc4_] = true;
         }
         var_62.onEditStart(var_20);
         if(var_1566)
         {
            var_803.showAll(_stuffs1,true,1);
            var_803.showAll(_stuffs2,true,2);
         }
         else
         {
            var_803.showAll(_stuffs1,false,0);
         }
         onEditStartUpdateCommonUI();
         var_62.onEditInitialized();
         restorePositionAndActivate();
      }
      
      public function get isUsingAdvancedSettings() : Boolean
      {
         return var_20 && (var_20.usingCustomInputSources || var_62.usingCustomAdvancedSettings);
      }
      
      public function stuffRemoved(param1:int) : void
      {
         if(_frame == null || var_20 == null)
         {
            return;
         }
         if(var_20.id == param1)
         {
            close();
            return;
         }
         if(_stuffs1[param1])
         {
            delete _stuffs1[param1];
            var _loc2_:Boolean = true;
         }
         if(_stuffs2[param1])
         {
            delete _stuffs2[param1];
            _loc2_ = true;
         }
      }
      
      public function clearStuffPicks() : void
      {
         hideFurniHighlights();
         _stuffs1 = new Dictionary();
         _stuffs2 = new Dictionary();
         onStuffsChanged();
      }
      
      public function resetToDefault() : void
      {
         var _loc2_:int = 0;
         savePosition();
         var_20.intParams = var_20.defaultIntParams.concat();
         var_20.stringParam = "";
         var _loc5_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < var_20.variableIds)
         {
            _loc5_.push(0);
            _loc2_ += 1;
         }
         var_20.variableIds = _loc5_;
         var_20.stuffIds = [];
         var_20.stuffIds2 = [];
         var_20.furniSourceTypes = var_20.inputSourcesConf.defaultFurniSources.concat();
         var_20.userSourceTypes = var_20.inputSourcesConf.defaultUserSources.concat();
         var _loc3_:class_3042 = var_20 as class_3042;
         var _loc1_:class_2531 = var_20 as class_2531;
         var _loc4_:SelectorDefinition = var_20 as SelectorDefinition;
         if(_loc3_ != null)
         {
            _loc3_.delayInPulses = 0;
         }
         if(_loc1_ != null)
         {
            _loc1_.quantifierCode = 0;
         }
         if(_loc4_ != null)
         {
            _loc4_.isFilter = false;
            _loc4_.isInvert = false;
         }
         prepareForUpdate(var_20);
         restorePositionAndActivate();
      }
      
      public function createClipboardCopy() : void
      {
         var _loc1_:class_2510 = resolveHolder();
         if(_loc1_ == null)
         {
            return;
         }
         var _loc3_:String = _loc1_.getKey() + "-" + var_62.code;
         var _loc2_:ClipboardWiredEntry = new ClipboardWiredEntry(var_62.readIntParamsFromForm(),var_62.readStringParamFromForm(),var_62.readVariableIdsFromForm(),getStuffIds(),getStuffIds2(),var_20.furniSourceTypes.concat(),var_20.userSourceTypes.concat());
         if(var_20 is class_3042)
         {
            _loc2_.delayInPulses = getActionDelay();
         }
         if(var_20 is class_2531)
         {
            _loc2_.quantifierCode = resolveQuantifier();
         }
         if(var_20 is SelectorDefinition)
         {
            _loc2_.isFilter = isSelectorFilter();
            _loc2_.isInvert = isSelectorInvert();
         }
         var_3247[_loc3_] = _loc2_;
         _frame.updateButtonDisabledStates();
         _roomEvents.notifications.addItem("${notification.wired.copied}","wired");
      }
      
      public function pasteFromClipboard() : void
      {
         var _loc3_:class_2510 = resolveHolder();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc6_:String = _loc3_.getKey() + "-" + var_62.code;
         var _loc5_:ClipboardWiredEntry = var_3247[_loc6_];
         if(_loc5_ == null)
         {
            return;
         }
         savePosition();
         var_20.intParams = _loc5_.intParams.concat();
         var_20.stringParam = _loc5_.stringParam.concat();
         var_20.variableIds = _loc5_.variableIds.concat();
         var_20.stuffIds = _loc5_.stuffIds.concat();
         var_20.stuffIds2 = _loc5_.stuffIds2.concat();
         var_20.furniSourceTypes = _loc5_.furniSourceTypes.concat();
         var_20.userSourceTypes = _loc5_.userSourceTypes.concat();
         var _loc2_:class_3042 = var_20 as class_3042;
         var _loc1_:class_2531 = var_20 as class_2531;
         var _loc4_:SelectorDefinition = var_20 as SelectorDefinition;
         if(_loc2_ != null)
         {
            _loc2_.delayInPulses = _loc5_.delayInPulses;
         }
         if(_loc1_ != null)
         {
            _loc1_.quantifierCode = _loc5_.quantifierCode;
         }
         if(_loc4_ != null)
         {
            _loc4_.isFilter = _loc5_.isFilter;
            _loc4_.isInvert = _loc5_.isInvert;
         }
         prepareForUpdate(var_20);
         restorePositionAndActivate();
      }
      
      public function hasCurrentElementInClipboard() : Boolean
      {
         var _loc1_:String = resolveHolder().getKey() + "-" + var_62.code;
         return _loc1_ in var_3247;
      }
      
      private function onStuffsChanged() : void
      {
         if(var_20 == null || _frame == null)
         {
            return;
         }
         var _loc3_:int = int(this.getStuffIds().length);
         var _loc1_:int = var_20.furniLimit;
         _roomEvents.localization.registerParameter("wiredfurni.pickfurnis.caption","count","" + _loc3_);
         _roomEvents.localization.registerParameter("wiredfurni.pickfurnis.caption","limit","" + _loc1_);
         if(var_245 != null)
         {
            for each(var _loc2_ in var_245)
            {
               _loc2_.refresh(var_20,var_62);
            }
         }
         _frame.updateButtonDisabledStates();
      }
      
      private function save() : void
      {
         var _loc1_:Object = null;
         if(var_20 == null || _frame == null)
         {
            return;
         }
         if(var_20 as SelectorDefinition != null && isSelectorInvert() && !isSelectorFilter())
         {
            _roomEvents.windowManager.confirm("${wiredfurni.danger.1.change.confirm.title}","${wiredfurni.danger.1.change.confirm.body}",0,confirmCallback);
         }
         else if(!isOwner(var_20.id) && !var_3916)
         {
            _roomEvents.windowManager.confirm("${wiredfurni.nonowner.change.confirm.title}","${wiredfurni.nonowner.change.confirm.body}",0,confirmCallback);
         }
         else
         {
            _loc1_ = var_62.requireConfirmation;
            if(_loc1_ != null)
            {
               _roomEvents.windowManager.confirm(_loc1_.title,_loc1_.body,0,confirmCallback);
            }
            else
            {
               update();
            }
         }
      }
      
      private function isSelectorFilter() : Boolean
      {
         return _selectorOptionsPreset != null && _selectorOptionsPreset.method_20(0).selected;
      }
      
      private function isSelectorInvert() : Boolean
      {
         return _selectorOptionsPreset != null && _selectorOptionsPreset.method_20(1).selected;
      }
      
      private function confirmCallback(param1:class_2001, param2:class_1758) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            var_3916 = true;
            update();
         }
      }
      
      public function onSaveFailure() : void
      {
         var_1314 = 0;
      }
      
      public function onSaveSuccess() : void
      {
         if(var_1314 == 0)
         {
            close();
         }
         else if(var_1314 == 1)
         {
            _roomEvents.notifications.addItem("${notification.wired.saved}","wired");
         }
         else if(var_1314 == 2)
         {
            _roomEvents.notifications.addItem("${notification.wired.pasted_into}","wired");
         }
         var_1314 = 0;
      }
      
      public function update(param1:int = 0, param2:int = -1) : void
      {
         var _loc3_:String = var_62.validate();
         if(_loc3_ != null)
         {
            _roomEvents.windowManager.alert("Update failed",_loc3_,0,null);
            return;
         }
         var_1314 = param1;
         if(param2 == -1)
         {
            param2 = var_20.id;
         }
         if(var_20 as class_3034 != null)
         {
            _roomEvents.send(new UpdateTriggerMessageComposer(param2,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),getStuffIds2(),resolveFurniSources(),resolveUserSources()));
         }
         else if(var_20 as class_3042 != null)
         {
            _roomEvents.send(new UpdateActionMessageComposer(param2,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),getStuffIds2(),getActionDelay(),resolveFurniSources(),resolveUserSources()));
         }
         else if(var_20 as class_2531 != null)
         {
            _roomEvents.send(new UpdateConditionMessageComposer(param2,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),getStuffIds2(),resolveQuantifier(),resolveFurniSources(),resolveUserSources()));
         }
         else if(var_20 as class_3525 != null)
         {
            _roomEvents.send(new UpdateAddonMessageComposer(param2,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),getStuffIds2(),resolveFurniSources(),resolveUserSources()));
         }
         else if(var_20 as SelectorDefinition != null)
         {
            _roomEvents.send(new UpdateSelectorMessageComposer(param2,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),getStuffIds2(),resolveFilterField(),resolveInverseField(),resolveFurniSources(),resolveUserSources()));
         }
         else if(var_20 as class_3381 != null)
         {
            _roomEvents.send(new UpdateVariableMessageComposer(param2,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),getStuffIds2(),resolveFurniSources(),resolveUserSources()));
         }
      }
      
      public function getActionDelay() : int
      {
         if(_delayPreset == null)
         {
            return 0;
         }
         return _delayPreset.value;
      }
      
      private function applySnapshot() : void
      {
         _roomEvents.send(new ApplySnapshotMessageComposer(var_20.id));
      }
      
      private function viewVariableInMenu() : void
      {
         var _loc1_:class_2404 = var_62 as class_2404;
         if(_loc1_ == null || _loc1_.initialVariableName.length == 0)
         {
            return;
         }
         _roomEvents.context.createLinkEvent("wiredmenu/open/variable_overview/" + _loc1_.initialVariableName);
      }
      
      private function resolveIntParams() : Array
      {
         return var_62.readIntParamsFromForm();
      }
      
      private function resolveVariableIds() : Array
      {
         return var_62.readVariableIdsFromForm();
      }
      
      private function resolveStringParam() : String
      {
         return var_62.readStringParamFromForm();
      }
      
      private function resolveFurniSources() : Array
      {
         return var_20.furniSourceTypes;
      }
      
      private function resolveUserSources() : Array
      {
         return var_20.userSourceTypes;
      }
      
      public function getStuffIds() : Array
      {
         var _loc2_:Array = [];
         for(var _loc1_ in _stuffs1)
         {
            _loc2_.push(int(_loc1_));
         }
         return _loc2_;
      }
      
      public function getStuffIds2() : Array
      {
         var _loc1_:Array = [];
         for(var _loc2_ in _stuffs2)
         {
            _loc1_.push(int(_loc2_));
         }
         return _loc1_;
      }
      
      public function resolveQuantifier() : int
      {
         if(var_479 == null)
         {
            return 0;
         }
         return var_479.selected;
      }
      
      public function resolveFilterField() : Boolean
      {
         return isSelectorFilter();
      }
      
      public function resolveInverseField() : Boolean
      {
         return isSelectorInvert();
      }
      
      private function getElementName(param1:int) : String
      {
         var _loc2_:class_1800 = _roomEvents.sessionDataManager.getFloorItemData(param1);
         if(_loc2_ == null)
         {
            class_21.log("COULD NOT FIND FURNIDATA FOR " + param1);
            return "NAME: " + param1;
         }
         return _loc2_.localizedName;
      }
      
      private function isOwner(param1:int) : Boolean
      {
         var _loc4_:IRoomObject = _roomEvents.roomEngine.getRoomObject(_roomEvents.roomId,param1,10);
         if(_loc4_ == null)
         {
            return false;
         }
         var _loc3_:IRoomObjectModel = _loc4_.getModel();
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc2_:Number = _loc4_.getModel().getNumber("furniture_owner_id");
         return _loc2_ == _roomEvents.sessionDataManager.userId;
      }
      
      public function onGuildMemberships(param1:GuildMembershipsMessageEvent) : void
      {
         if(var_62 != null)
         {
            var_62.onGuildMemberships(param1);
         }
      }
      
      public function updateSourceContainer(param1:int, param2:int) : void
      {
         if(var_245 != null)
         {
            for each(var _loc3_ in var_245)
            {
               if(_loc3_.baseSourceType == param1 && _loc3_.id == param2)
               {
                  _loc3_.refresh(var_20,var_62);
               }
            }
         }
      }
      
      public function setMergedSourceType(param1:int, param2:int) : void
      {
         if(var_245 != null)
         {
            for each(var _loc3_ in var_245)
            {
               if(_loc3_.id == param1 && _loc3_.baseSourceType == WiredInputSourcePicker.MERGED_SOURCE)
               {
                  _loc3_.sourceType = param2;
               }
            }
         }
      }
      
      public function get wiredStyle() : WiredStyle
      {
         return var_1619;
      }
      
      public function get presetManager() : PresetManager
      {
         return var_182;
      }
      
      private function get isResizeEnabled() : Boolean
      {
         return false;
      }
      
      private function get useCache() : Boolean
      {
         return true;
      }
      
      public function clearCache() : void
      {
         close();
         for each(var _loc1_ in _configurationCache)
         {
            _loc1_.frame.dispose();
         }
         _configurationCache = new Dictionary();
      }
   }
}

