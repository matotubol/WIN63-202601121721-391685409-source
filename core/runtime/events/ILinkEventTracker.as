package com.sulake.core.runtime.events
{
   public interface ILinkEventTracker
   {
      
      function get linkPattern() : String;
      
      function linkReceived(param1:String) : void;
   }
}

