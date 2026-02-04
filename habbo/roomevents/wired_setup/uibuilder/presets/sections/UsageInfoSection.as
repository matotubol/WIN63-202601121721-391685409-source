package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class UsageInfoSection extends AbstractSectionPreset
   {
      
      private var var_3050:TextPreset;
      
      public function UsageInfoSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:Boolean = false)
      {
         super(param1,param2,param3);
         var _loc6_:TextParam = new TextParam(1);
         _loc6_.textColor = param3.softTextColor;
         var_3050 = param2.createText(param4,_loc6_);
         initializeSection(l("general_box_info"),var_3050,param5 ? SectionParam.COLLAPSED : SectionParam.var_2495);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         var_3050 = null;
      }
   }
}

