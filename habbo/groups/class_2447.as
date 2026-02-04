package com.sulake.habbo.groups
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.events.class_1758;
   import package_3.class_1818;
   
   public class class_2447
   {
      
      public static const TYPE_REGULAR:int = 0;
      
      public static const TYPE_EXCLUSIVE:int = 1;
      
      public static const const_68:int = 2;
      
      public static const TYPE_LARGE:int = 3;
      
      public static const const_73:int = 4;
      
      public static const RIGHTS_MEMBERS:int = 0;
      
      public static const const_505:int = 1;
      
      private var var_24:GuildSettingsData;
      
      private var var_2161:ISelectorWindow;
      
      private var var_2924:IRadioButtonWindow;
      
      private var var_3655:IRadioButtonWindow;
      
      private var var_3490:IRadioButtonWindow;
      
      private var var_2878:class_1885;
      
      public function class_2447()
      {
         super();
      }
      
      public function prepare(param1:class_1812) : void
      {
         var _loc2_:class_1812 = param1.findChildByName("step_cont_5") as class_1812;
         var_2161 = _loc2_.findChildByName("group_type_selector") as ISelectorWindow;
         var_2924 = _loc2_.findChildByName("rb_type_regular") as IRadioButtonWindow;
         var_2924.procedure = onRegularGuildType;
         var_3655 = _loc2_.findChildByName("rb_type_exclusive") as IRadioButtonWindow;
         var_3655.procedure = onExclusiveGuildType;
         var_3490 = _loc2_.findChildByName("rb_type_private") as IRadioButtonWindow;
         var_3490.procedure = onPrivateGuildType;
         var_2878 = _loc2_.findChildByName("cb_member_rights") as class_1885;
         var_2878.procedure = onMembersHaveRights;
      }
      
      public function refresh(param1:class_1818) : void
      {
         var_24 = new GuildSettingsData(param1);
         switch(var_24.guildType)
         {
            case 0:
               var_2161.setSelected(var_2924);
               break;
            case 1:
               var_2161.setSelected(var_3655);
               break;
            case 2:
               var_2161.setSelected(var_3490);
               break;
            default:
               var_2161.setSelected(var_2924);
         }
         if(var_24.rightsLevel == 0)
         {
            var_2878.select();
         }
         else
         {
            var_2878.unselect();
         }
         var_2161.invalidate();
      }
      
      private function onRegularGuildType(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WE_SELECT")
         {
            var_24.guildType = 0;
         }
      }
      
      private function onExclusiveGuildType(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WE_SELECT")
         {
            var_24.guildType = 1;
         }
      }
      
      private function onPrivateGuildType(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WE_SELECT")
         {
            var_24.guildType = 2;
         }
      }
      
      private function onMembersHaveRights(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WE_SELECT")
         {
            var_24.rightsLevel = 0;
         }
         if(param1.type == "WE_UNSELECT")
         {
            var_24.rightsLevel = 1;
         }
      }
      
      public function resetModified() : void
      {
         if(var_24 != null && var_24.isModified)
         {
            var_24.resetModified();
         }
      }
      
      public function get guildType() : int
      {
         return var_24.guildType;
      }
      
      public function get rightsLevel() : int
      {
         return var_24.rightsLevel;
      }
      
      public function get isInitialized() : Boolean
      {
         return var_24 != null;
      }
   }
}

