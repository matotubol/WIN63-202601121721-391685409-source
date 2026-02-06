package com.sulake.habbo.navigator.context
{
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import package_15.NavigatorMetaDataEventParser;
   import package_25.class_2073;
   import package_25.class_3644;
   
   public class ContextContainer
   {
      
      private var _navigator:HabboNewNavigator;
      
      private var var_2074:class_55;
      
      private var var_3080:Vector.<class_2073> = new Vector.<class_2073>();
      
      public function ContextContainer(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function hasContextFor(param1:String) : Boolean
      {
         if(!var_2074)
         {
            return false;
         }
         return var_2074.hasKey(param1);
      }
      
      public function initialize(param1:NavigatorMetaDataEventParser) : void
      {
         var_2074 = new class_55();
         for each(var _loc2_ in param1.topLevelContexts)
         {
            var_2074.add(_loc2_.searchCode,_loc2_.quickLinks);
         }
      }
      
      public function getTopLevelSearches() : Array
      {
         return var_2074.getKeys();
      }
      
      public function get savedSearches() : Vector.<class_2073>
      {
         return var_3080;
      }
      
      public function set savedSearches(param1:Vector.<class_2073>) : void
      {
         var_3080 = param1;
      }
      
      public function isReady() : Boolean
      {
         return var_2074 != null;
      }
   }
}

