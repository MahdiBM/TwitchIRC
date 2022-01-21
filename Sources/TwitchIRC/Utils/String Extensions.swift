
extension RangeReplaceableCollection where Element == Character {
    
    /// Separates the string by the given separator only with the first matching case.
    func components(separatedBy separator: String) -> [Self] {
        let separatorLength = separator.count
        guard separatorLength != 0 else { return [self] }
        guard !(self.count < separatorLength) else { return [self] }
        
        let separatorChars = [Character](separator)
        
        func oneSplit(_ string: [Character]) -> (lhs: Self, rhs: [Character])? {
            guard !string.isEmpty else { return nil }
            
            let stringLength = string.count
            let maxIdx = separatorLength - 1
            var lastIdx: Int? = nil
            
            for idx in 0..<stringLength {
                if let lastIdxUnwrapped = lastIdx {
                    let nextIdx = lastIdxUnwrapped + 1
                    if nextIdx == maxIdx {
                        if string[idx] == separatorChars[nextIdx] {
                            let startingIdx = idx - maxIdx
                            let lhs = Self(string[0..<startingIdx])
                            let rhs = [Character](string[(idx + 1)...])
                            return (lhs: lhs, rhs: rhs)
                        } else {
                            if string[idx] == separatorChars[0] {
                                lastIdx = 0
                            } else {
                                lastIdx = nil
                            }
                        }
                    } else {
                        if string[idx] == separatorChars[nextIdx] {
                            lastIdx = lastIdxUnwrapped + 1
                        } else {
                            lastIdx = nil
                        }
                    }
                } else {
                    if string[idx] == separatorChars[0] {
                        lastIdx = 0
                        if separatorLength == 1 {
                            let lhs = Self(string[0..<idx])
                            let rhs = [Character](string[(idx + 1)...])
                            return (lhs: lhs, rhs: rhs)
                        }
                    }
                }
            }
            
            return nil
        }
        
        func recursiveOneSplit(_ string: [Character]) -> [Self] {
            if let (lhs, rhs) = oneSplit(string) {
                return [lhs] + recursiveOneSplit(rhs)
            } else {
                return [Self(string)]
            }
        }
        
        return recursiveOneSplit([Character](self))
    }
    
    /// Separates the string by the given separator only with the first matching case.
    func componentsOneSplit(separatedBy separator: String) -> (lhs: Self, rhs: Self)? {
        let separatorLength = separator.count
        let selfLength = self.count
        guard separatorLength != 0 else { return nil }
        guard !(selfLength < separatorLength) else { return nil }
        
        let selfChars = [Character](self)
        let separatorChars = [Character](separator)
        
        let maxIdx = separatorLength - 1
        var lastIdx: Int? = nil
        
        for idx in 0..<selfLength {
            if let lastIdxUnwrapped = lastIdx {
                let nextIdx = lastIdxUnwrapped + 1
                if nextIdx == maxIdx {
                    if selfChars[idx] == separatorChars[nextIdx] {
                        let startingIdx = idx - maxIdx
                        let lhs = Self(selfChars[0..<startingIdx])
                        let rhs = Self(selfChars[(idx + 1)...])
                        return (lhs: lhs, rhs: rhs)
                    } else {
                        if selfChars[idx] == separatorChars[0] {
                            lastIdx = 0
                        } else {
                            lastIdx = nil
                        }
                    }
                } else {
                    if selfChars[idx] == separatorChars[nextIdx] {
                        lastIdx = lastIdxUnwrapped + 1
                    } else {
                        lastIdx = nil
                    }
                }
            } else {
                if selfChars[idx] == separatorChars[0] {
                    lastIdx = 0
                    if separatorLength == 1 {
                        let lhs = Self(selfChars[0..<idx])
                        let rhs = Self(selfChars[(idx + 1)...])
                        return (lhs: lhs, rhs: rhs)
                    }
                }
            }
        }
        
        return nil
    }
}
