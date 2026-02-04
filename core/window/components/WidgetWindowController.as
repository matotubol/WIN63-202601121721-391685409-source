package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1901;
   import com.sulake.core.window.class_35;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class WidgetWindowController extends WindowController implements class_2010
   {
      
      private var var_2939:class_35;
      
      private var var_3481:String = "";
      
      private var var_16:class_1901;
      
      public function WidgetWindowController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         var_2939 = param5.getWidgetFactory();
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(var_16 != null)
            {
               var_16.dispose();
               var_16 = null;
            }
            var_2939 = null;
            super.dispose();
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = var_16 != null ? var_16.properties : [];
         _loc1_.unshift(createProperty("widget_type",var_3481));
         return super.properties.concat(_loc1_);
      }
      
      override public function set properties(param1:Array) : void
      {
         var _loc3_:String = null;
         for each(var _loc2_ in param1)
         {
            if(_loc2_.key == "widget_type")
            {
               _loc3_ = String(_loc2_.value);
               if(var_3481 != _loc3_)
               {
                  if(var_16 != null)
                  {
                     removeChildAt(0);
                     var_16.dispose();
                  }
                  var_16 = var_2939.createWidget(String(_loc2_.value),this);
                  var_3481 = _loc3_;
               }
               break;
            }
         }
         if(var_16 != null)
         {
            var_16.properties = param1;
         }
         super.properties = param1;
      }
      
      override public function set color(param1:uint) : void
      {
         super.color = param1;
         var _loc2_:Array = [];
         groupChildrenWithTag("_COLORIZE",_loc2_,-1);
         for each(var _loc3_ in _loc2_)
         {
            _loc3_.color = param1;
         }
      }
      
      public function get iterator() : IIterator
      {
         return var_16 != null ? var_16.iterator : EmptyIterator.INSTANCE;
      }
      
      public function get widget() : class_1901
      {
         return var_16;
      }
      
      public function get rootWindow() : class_1741
      {
         return getChildAt(0);
      }
      
      public function set rootWindow(param1:class_1741) : void
      {
         removeChildAt(0);
         if(param1 == null)
         {
            return;
         }
         addChild(param1);
         if(param1.tags.indexOf("_EXCLUDE") < 0)
         {
            param1.tags.push("_EXCLUDE");
         }
      }
   }
}

