﻿using System;

namespace PChecker.Runtime.Values
{
    public interface IPValue : IEquatable<IPValue>
    {
        IPValue Clone();

        /// <summary>
        /// Returns a string representation of this Value, such that strings are
        /// escaped along with any necessary metacharacters.
        /// </summary>
        string ToEscapedString()
        {
            return ToString();
        }

        object ToDict()
        {
            return ToEscapedString();
        }
    }
}