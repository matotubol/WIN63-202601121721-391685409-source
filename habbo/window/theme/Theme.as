package com.sulake.habbo.window.theme
{
   import com.sulake.core.window.theme.PropertyMap;
   
   public class Theme
   {
      
      public static const NONE:String = "None";
      
      public static const ICON:String = "Icon";
      
      public static const LEGACY_BORDER:String = "Legacy border";
      
      public static const VOLTER:String = "Volter";
      
      public static const UBUNTU:String = "Ubuntu";
      
      public static const ILLUMINA_LIGHT:String = "Illumina Light";
      
      public static const ILLUMINA_DARK:String = "Illumina Dark";
      
      private var _name:String;
      
      private var var_4731:Boolean;
      
      private var var_3117:uint;
      
      private var var_3711:uint;
      
      private var var_2210:PropertyMap;
      
      public function Theme(param1:String, param2:Boolean, param3:uint, param4:uint, param5:PropertyMap)
      {
         super();
         _name = param1;
         var_4731 = param2;
         var_3117 = param3;
         var_3711 = param4;
         var_2210 = param5;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get isReal() : Boolean
      {
         return var_4731;
      }
      
      public function get baseStyle() : uint
      {
         return var_3117;
      }
      
      public function get styleCount() : uint
      {
         return var_3711;
      }
      
      public function get propertyDefaults() : PropertyMap
      {
         return var_2210;
      }
      
      public function coversStyle(param1:uint) : Boolean
      {
         return param1 >= var_3117 && param1 < var_3117 + var_3711;
      }
   }
}

