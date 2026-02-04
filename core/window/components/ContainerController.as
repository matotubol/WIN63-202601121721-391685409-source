package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.graphics.GraphicContext;
   import com.sulake.core.window.graphics.IGraphicContext;
   import com.sulake.core.window.iterators.ContainerIterator;
   import com.sulake.core.window.utils.IIterator;
   import flash.geom.Rectangle;
   
   public class ContainerController extends WindowController implements class_1812
   {
      
      public function ContainerController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         var_326 = _background || testParamFlag(1) || !testParamFlag(16);
      }
      
      public function get iterator() : IIterator
      {
         return new ContainerIterator(this);
      }
      
      override public function getGraphicContext(param1:Boolean) : IGraphicContext
      {
         if(param1 && !var_43)
         {
            var_43 = new GraphicContext("GC {" + _name + "}",testParamFlag(16) ? 4 : 1,rectangle);
            var_43.visible = var_588;
         }
         return var_43;
      }
   }
}

