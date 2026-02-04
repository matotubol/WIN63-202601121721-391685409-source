package com.sulake.habbo.ui.widget.poll
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   
   public class PollSession implements class_13
   {
      
      private var var_197:int = -1;
      
      private var var_2105:PollWidget;
      
      private var var_856:class_3726;
      
      private var var_802:class_3726;
      
      private var _endMessage:String = "";
      
      private var _disposed:Boolean = false;
      
      public function PollSession(param1:int, param2:PollWidget)
      {
         super();
         var_197 = param1;
         var_2105 = param2;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_856 != null)
         {
            var_856.dispose();
            var_856 = null;
         }
         if(var_802 != null)
         {
            var_802.dispose();
            var_802 = null;
         }
         var_2105 = null;
         _disposed = true;
      }
      
      public function showOffer(param1:String, param2:String) : void
      {
         hideOffer();
         var_856 = new PollOfferDialog(var_197,param1,param2,var_2105);
         var_856.start();
      }
      
      public function hideOffer() : void
      {
         if(var_856 is PollOfferDialog)
         {
            if(!var_856.disposed)
            {
               var_856.dispose();
            }
            var_856 = null;
         }
      }
      
      public function showContent(param1:String, param2:String, param3:Array, param4:Boolean) : void
      {
         hideOffer();
         hideContent();
         _endMessage = param2;
         var_802 = new PollContentDialog(var_197,param1,param3,var_2105,param4);
         var_802.start();
      }
      
      public function hideContent() : void
      {
         if(var_802 is PollContentDialog)
         {
            if(!var_802.disposed)
            {
               var_802.dispose();
            }
            var_802 = null;
         }
      }
      
      public function showThanks() : void
      {
         var_2105.windowManager.alert("${poll_thanks_title}",_endMessage,0,function(param1:class_1750, param2:class_1758):void
         {
            param1.dispose();
         });
      }
   }
}

