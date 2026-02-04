package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.addons.levelupper.AbstractLevelUpConfig;
   import com.sulake.habbo.roomevents.wired_setup.addons.levelupper.ExponentialLevelUpper;
   import com.sulake.habbo.roomevents.wired_setup.addons.levelupper.InterpolateLevelUpper;
   import com.sulake.habbo.roomevents.wired_setup.addons.levelupper.LinearLevelUpper;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextAreaParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.applications.SubVariableParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextAreaPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications.LevelXpPreviewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications.SubVariableCreatorPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedNumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class class_3833 extends DefaultAddonType implements class_31
   {
      
      private static var MODE_MANUAL:int = 0;
      
      private static var MODE_LINEAR:int = 1;
      
      private static var MODE_EXPONENTIAL:int = 2;
      
      private var _modeOptionGroup:RadioGroupPreset;
      
      private var var_2458:TextAreaPreset;
      
      private var var_2121:NamedNumberInputPreset;
      
      private var _maxLevel1:NamedNumberInputPreset;
      
      private var var_2122:NamedNumberInputPreset;
      
      private var var_2025:NamedNumberInputPreset;
      
      private var _maxLevel2:NamedNumberInputPreset;
      
      private var _previewPreset:LevelXpPreviewPreset;
      
      private var _subVariableCreatorPreset:SubVariableCreatorPreset;
      
      private var _cachedIntParams:Array;
      
      private var var_4478:String;
      
      public function class_3833()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4074.VARIABLE_LEVEL_UP;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc7_:RadioButtonParam = new RadioButtonParam(1,loc("wiredfurni.params.levelup." + "mode.1"));
         var_2121 = param1.createNamedNumberInput(new NumberInputParam(100,1,100000,35),loc("wiredfurni.params.levelup." + "step_size"));
         _maxLevel1 = param1.createNamedNumberInput(new NumberInputParam(50,2,100000,20),loc("wiredfurni.params.levelup." + "max_level"));
         _loc7_.extra2 = param1.createSimpleListView(true,[var_2121,_maxLevel1]);
         var _loc9_:RadioButtonParam = new RadioButtonParam(2,loc("wiredfurni.params.levelup." + "mode.2"));
         var_2122 = param1.createNamedNumberInput(new NumberInputParam(100,1,100000,35),loc("wiredfurni.params.levelup." + "first_level_xp"));
         var_2025 = param1.createNamedNumberInput(new NumberInputParam(20,1,100000,35),loc("wiredfurni.params.levelup." + "increase_factor"));
         _maxLevel2 = param1.createNamedNumberInput(new NumberInputParam(50,2,100000,20),loc("wiredfurni.params.levelup." + "max_level"));
         _loc9_.extra2 = param1.createSimpleListView(true,[var_2122,var_2025,_maxLevel2]);
         var _loc6_:RadioButtonParam = new RadioButtonParam(0,loc("wiredfurni.params.levelup." + "mode.0"));
         var_2458 = param1.createTextArea(new TextAreaParam(60,-1,-1,30,1000,"",loc("wiredfurni.params.levelup." + "interpolation_placeholder"),"0123456789=\r"));
         _loc6_.extra2 = var_2458;
         _loc8_.push(_loc7_);
         _loc8_.push(_loc9_);
         _loc8_.push(_loc6_);
         _modeOptionGroup = param1.createRadioGroup(_loc8_);
         var _loc10_:SectionPreset = param1.createSection(loc("wiredfurni.params.levelup." + "mode"),_modeOptionGroup,SectionParam.var_2495);
         _previewPreset = param1.createLevelXpPreview([1,2,3,5,10,20]);
         var _loc11_:SectionPreset = param1.createSection(loc("wiredfurni.params.levelup." + "preview"),_previewPreset,SectionParam.COLLAPSED);
         var _loc4_:Array = [new SubVariableParam(0,"current_level"),new SubVariableParam(1,"current_xp"),new SubVariableParam(2,"progress"),new SubVariableParam(3,"progress_percentage"),new SubVariableParam(4,"xp_required"),new SubVariableParam(5,"xp_remaining"),new SubVariableParam(6,"is_maxed"),new SubVariableParam(7,"max_level")];
         _subVariableCreatorPreset = param1.createSubVariableCreator("wiredfurni.params.levelup." + "subvariable.",_loc4_);
         var _loc12_:SectionPreset = param1.createSection(loc("wiredfurni.params.create_subvariables"),_subVariableCreatorPreset,SectionParam.var_2495);
         param3.addElements(_loc10_,_loc11_,_loc12_);
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         param3.context.registerUpdateReceiver(this,0);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc7_:int = param1.getInt(0);
         var _loc2_:int = param1.getInt(1);
         var _loc6_:int = param1.getInt(2);
         var _loc4_:int = param1.getInt(3);
         var _loc3_:int = param1.getInt(4);
         var _loc5_:String = param1.stringParam;
         _subVariableCreatorPreset.mask = _loc7_;
         _modeOptionGroup.selected = _loc2_;
         var_2458.reset();
         _maxLevel1.reset();
         _maxLevel2.reset();
         var_2121.reset();
         var_2122.reset();
         var_2025.reset();
         if(_loc2_ == MODE_MANUAL)
         {
            var_2458.text = _loc5_;
         }
         else if(_loc2_ == MODE_LINEAR)
         {
            var_2121.value = _loc6_;
            _maxLevel1.value = _loc4_;
         }
         else if(_loc2_ == MODE_EXPONENTIAL)
         {
            var_2122.value = _loc6_;
            var_2025.value = _loc4_;
            _maxLevel2.value = _loc3_;
         }
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc2_:Array = [];
         _loc2_.push(_subVariableCreatorPreset.mask);
         var _loc1_:int = _modeOptionGroup.selected;
         _loc2_.push(_loc1_);
         if(_loc1_ == MODE_LINEAR)
         {
            _loc2_.push(var_2121.value);
            _loc2_.push(_maxLevel1.value);
         }
         else if(_loc1_ == MODE_EXPONENTIAL)
         {
            _loc2_.push(var_2122.value);
            _loc2_.push(var_2025.value);
            _loc2_.push(_maxLevel2.value);
         }
         return _loc2_;
      }
      
      override public function readStringParamFromForm() : String
      {
         var _loc1_:int = _modeOptionGroup.selected;
         if(_loc1_ == 0)
         {
            return var_2458.text;
         }
         return "";
      }
      
      public function update(param1:uint) : void
      {
         var _loc4_:Array = null;
         var _loc2_:String = null;
         var _loc7_:Boolean = false;
         var _loc5_:AbstractLevelUpConfig = null;
         var _loc6_:Array = null;
         if(_previewPreset)
         {
            _loc4_ = readIntParamsFromForm();
            _loc2_ = readStringParamFromForm();
            _loc7_ = _cachedIntParams == null || !Util.compareIntArrays(_cachedIntParams,_loc4_) || var_4478 != _loc2_;
            if(_loc7_)
            {
               _loc5_ = simulateLevelUpper();
               _loc6_ = [];
               if(_loc5_ != null)
               {
                  for each(var _loc3_ in _previewPreset.previewLevels)
                  {
                     if(_loc3_ <= 0 || _loc3_ > _loc5_.maxLevel)
                     {
                        break;
                     }
                     _loc6_.push(_loc5_.xpForLevel(_loc3_));
                  }
               }
               _previewPreset.setPreviewXps(_loc6_);
            }
            _cachedIntParams = _loc4_;
            var_4478 = _loc2_;
         }
      }
      
      private function simulateLevelUpper() : AbstractLevelUpConfig
      {
         var _loc2_:AbstractLevelUpConfig = null;
         var _loc3_:class_55 = null;
         var _loc1_:int = _modeOptionGroup.selected;
         if(_loc1_ == MODE_MANUAL)
         {
            _loc3_ = parseLevelToXpMap();
            if(_loc3_ == null)
            {
               return null;
            }
            _loc2_ = new InterpolateLevelUpper(_loc3_);
         }
         else if(_loc1_ == MODE_LINEAR)
         {
            _loc2_ = new LinearLevelUpper(var_2121.value,_maxLevel1.value);
         }
         else if(_loc1_ == MODE_EXPONENTIAL)
         {
            _loc2_ = new ExponentialLevelUpper(var_2122.value,var_2025.value,_maxLevel2.value);
         }
         return _loc2_;
      }
      
      private function parseLevelToXpMap() : class_55
      {
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:String = readStringParamFromForm();
         var _loc3_:class_55 = new class_55();
         var _loc4_:Array = _loc2_.split("\n");
         var _loc1_:int = 1;
         var _loc8_:int = 0;
         for each(var _loc5_ in _loc4_)
         {
            _loc6_ = _loc5_.split("=",2);
            if(_loc6_.length >= 2)
            {
               try
               {
                  _loc7_ = int(_loc6_[0]);
                  _loc9_ = int(_loc6_[1]);
               }
               catch(e:Error)
               {
                  continue;
               }
               if(_loc7_ <= _loc1_ || _loc9_ <= _loc8_)
               {
                  return null;
               }
               _loc3_.add(_loc7_,_loc9_);
               _loc1_ = _loc7_;
               _loc8_ = _loc9_;
            }
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

