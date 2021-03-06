
extension RangeReplaceableCollection where Element == Character, Index == String.Index {
    
    /// Splits self by a given separator into as many pieces as possible.
    ///
    /// Not naming it `components(separatedBy:)` to make
    /// sure it's not confused with that of `Foundation`.
    func componentsSeparatedBy(separator: String) -> [Self] {
        let separatorLength = separator.count
        guard separatorLength != 0 else { return [self] }
        let selfLength = self.count
        guard !(selfLength < separatorLength) else { return [self] }
        
        var endingIndices = ContiguousArray<Index>()
        
        let separatorStartIndex = separator.startIndex
        let maxIdx = separator.index(separatorStartIndex, offsetBy: separatorLength - 1)
        let selfStartIndex = self.startIndex
        let selfEndIndex = self.endIndex
        
        var lastIdx: Index? = nil
        var indexSeparatorStartedInSelf: Index? = nil
        var idx = selfStartIndex
        
        while idx < selfEndIndex {
            if let lastIdxUnwrapped = lastIdx {
                let nextIdx = separator.index(after: lastIdxUnwrapped)
                if nextIdx == maxIdx {
                    if self[idx] == separator[nextIdx] {
                        endingIndices.append(idx)
                        lastIdx = nil
                    } else if self[idx] == separator[separatorStartIndex] {
                        lastIdx = separatorStartIndex
                    } else {
                        lastIdx = nil
                    }
                } else {
                    if self[idx] == separator[nextIdx] {
                        lastIdx = nextIdx
                    } else if self[idx] == separator[separatorStartIndex] {
                        lastIdx = separatorStartIndex
                    } else {
                        idx = self.index(after: indexSeparatorStartedInSelf!)
                        lastIdx = nil
                        continue
                    }
                }
            } else {
                if self[idx] == separator[separatorStartIndex] {
                    if separatorLength == 1 {
                        endingIndices.append(idx)
                    } else {
                        indexSeparatorStartedInSelf = idx
                        lastIdx = separatorStartIndex
                    }
                }
            }
            idx = self.index(after: idx)
        }
        
        let indicesLength = endingIndices.count
        guard indicesLength != 0 else { return [self] }
        let arrayLength = endingIndices.count + 1
        var array = Array<Self>()
        array.reserveCapacity(arrayLength)
        
        for idx in 0..<arrayLength {
            if idx == 0 {
                let endingIndex = endingIndices[0]
                if let upperBound = self.index(
                    endingIndex,
                    offsetBy: -separatorLength,
                    limitedBy: selfStartIndex
                ) {
                    array.append(Self(self[...upperBound]))
                } else {
                    array.append(Self())
                }
            } else if idx < indicesLength {
                let lastIndex = endingIndices[idx - 1]
                let nextIndex = endingIndices[idx]
                let lowerBound = self.index(after: lastIndex)
                if let upperBound = self.index(
                    nextIndex,
                    offsetBy: -separatorLength,
                    limitedBy: lowerBound
                ) {
                    array.append(Self(self[lowerBound...upperBound]))
                } else {
                    array.append(Self())
                }
            } else {
                let afterLast = self.index(after: endingIndices.last!)
                array.append(Self(self[afterLast...]))
            }
        }
        
        return array
    }
    
    /// Splits self into two pieces by a given separator, if the separator exists in self.
    func componentsOneSplit(separatedBy separator: String) -> (lhs: Self, rhs: Self)? {
        let separatorLength = separator.count
        guard separatorLength != 0 else { return nil }
        let selfLength = self.count
        guard !(selfLength < separatorLength) else { return nil }
        
        let separatorStartIndex = separator.startIndex
        let maxIdx = separator.index(separatorStartIndex, offsetBy: separatorLength - 1)
        let endIndex = self.endIndex
        
        var lastIdx: Index? = nil
        var indexSeparatorStartedInSelf: Index? = nil
        var idx = self.startIndex
        
        while idx < endIndex {
            if let lastIdxUnwrapped = lastIdx {
                let nextIdx = separator.index(after: lastIdxUnwrapped)
                if nextIdx == maxIdx {
                    if self[idx] == separator[nextIdx] {
                        let startingIdx = self.index(idx, offsetBy: -(separatorLength - 1))
                        let lhs = Self(self[..<startingIdx])
                        let rhsLowerBound = self.index(after: idx)
                        let rhs = Self(self[rhsLowerBound...])
                        return (lhs: lhs, rhs: rhs)
                    } else if self[idx] == separator[separatorStartIndex] {
                        lastIdx = separatorStartIndex
                    } else {
                        lastIdx = nil
                    }
                } else {
                    if self[idx] == separator[nextIdx] {
                        lastIdx = separator.index(after: lastIdxUnwrapped)
                    } else if self[idx] == separator[separatorStartIndex] {
                        lastIdx = separatorStartIndex
                    } else {
                        idx = self.index(after: indexSeparatorStartedInSelf!)
                        lastIdx = nil
                        continue
                    }
                }
            } else {
                if self[idx] == separator[separatorStartIndex] {
                    if separatorLength == 1 {
                        let lhs = Self(self[..<idx])
                        let rhsLowerBound = self.index(after: idx)
                        let rhs = Self(self[rhsLowerBound...])
                        return (lhs: lhs, rhs: rhs)
                    }
                    indexSeparatorStartedInSelf = idx
                    lastIdx = separatorStartIndex
                }
            }
            idx = self.index(after: idx)
        }
        
        return nil
    }
}
